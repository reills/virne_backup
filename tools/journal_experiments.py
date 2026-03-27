#!/usr/bin/env python3
"""
Journal experiment orchestrator.

Implemented foundations:
1. Strict Hydra key validation for generated overrides.
2. No '+' overrides on critical keys.
3. Stage-safe run_id rules and train/eval collision checks.
4. Fixed-dataset PN-load precedence micro-check.
5. Canonical dataset generation with stream integrity validation.
6. Offline solvability slice planning + compatibility/conversion guard path.
7. Preflight k-semantics parity micro-check for pooled k-ablation methods.
8. Eval orchestration with model attachment, timeout controls, and watchdog fallback.
"""
from __future__ import annotations

import argparse
import copy
import csv
import hashlib
import json
import os
import re
import shlex
import shutil
import subprocess
import sys
import tempfile
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass, replace
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, List, Mapping, Optional, Sequence, Tuple

import hydra
import networkx as nx
from omegaconf import DictConfig, ListConfig, OmegaConf, open_dict

try:
    import fcntl
except Exception:  # pragma: no cover - non-POSIX fallback
    fcntl = None

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from virne.network import PhysicalNetwork, VirtualNetwork, VirtualNetworkRequestSimulator
from virne.solver import SolverRegistry
from virne.system.base_system import BaseSystem
from virne.utils.config import add_simulation_into_config
from virne.utils.setting import read_setting


class PreflightFailure(RuntimeError):
    """Raised when one or more preflight checks fail."""


class _NullLogger:
    """Minimal logger for direct BaseSystem.load_dataset calls in preflight."""

    def critical(self, *_args: Any, **_kwargs: Any) -> None:
        return

    def info(self, *_args: Any, **_kwargs: Any) -> None:
        return

    def debug(self, *_args: Any, **_kwargs: Any) -> None:
        return

    def warning(self, *_args: Any, **_kwargs: Any) -> None:
        return

    def error(self, *_args: Any, **_kwargs: Any) -> None:
        return

    def exception(self, *_args: Any, **_kwargs: Any) -> None:
        return


@dataclass(frozen=True)
class OverrideSpec:
    raw: str
    key: str
    value: str
    has_plus: bool


@dataclass(frozen=True)
class PlannedJob:
    stage: str
    method_key: str
    solver_name: str
    topology_key: str
    scenario_key: str
    dataset_scenario_key: str
    train_source_scenario_key: Optional[str]
    seed: int
    k_value: int
    run_id: str
    dataset_dir: str
    source_dataset_dir: Optional[str]
    is_offline_slice: bool
    topology_file_path: str
    overrides: Tuple[str, ...]


@dataclass(frozen=True)
class DatasetSpec:
    scenario_key: str
    topology_key: str
    seed: int
    split: str
    dataset_dir: str
    topology_file_path: str


@dataclass(frozen=True)
class GeneralizationCell:
    train_scenario_key: str
    eval_scenario_key: str
    topology_key: str
    seed: int


@dataclass(frozen=True)
class OfflineSlicePlan:
    enabled: bool
    method_keys: Tuple[str, ...]
    topology_keys: Tuple[str, ...]
    scenario_keys: Tuple[str, ...]
    seeds: Tuple[int, ...]
    k_eval_values: Tuple[int, ...]
    conversion_enabled: bool
    dataset_suffix: str


REQUIRED_PROFILES: Tuple[str, ...] = ('smoke', 'core', 'full')
MODEL_REGISTRY_COLUMNS: Tuple[str, ...] = (
    'method',
    'solver_name',
    'topology',
    'scenario',
    'seed',
    'k_train',
    'model_path',
    'run_id',
    'updated_at_utc',
)


def _as_dict(value: Any) -> Dict[str, Any]:
    if isinstance(value, DictConfig):
        result = OmegaConf.to_container(value, resolve=True)
    else:
        result = value
    if not isinstance(result, dict):
        raise ValueError(f'Expected mapping, got {type(result).__name__}')
    return result


def _as_list(value: Any) -> List[Any]:
    if isinstance(value, ListConfig):
        result = OmegaConf.to_container(value, resolve=True)
    else:
        result = value
    if not isinstance(result, list):
        raise ValueError(f'Expected list, got {type(result).__name__}')
    return result


def _format_override_value(value: Any) -> str:
    if isinstance(value, bool):
        return 'true' if value else 'false'
    if value is None:
        return 'null'
    if isinstance(value, (int, float)):
        return str(value)
    if isinstance(value, (list, dict)):
        return json.dumps(value)
    return str(value)


def _flatten_override_mapping(prefix: str, value: Any) -> List[str]:
    if isinstance(value, (DictConfig, ListConfig)):
        value = OmegaConf.to_container(value, resolve=True)
    if isinstance(value, dict):
        flattened: List[str] = []
        for key, child in value.items():
            child_prefix = f'{prefix}.{key}' if prefix else str(key)
            flattened.extend(_flatten_override_mapping(child_prefix, child))
        return flattened
    return [f'{prefix}={_format_override_value(value)}']


def _resolve_path(path_text: str, root: Path) -> Path:
    path = Path(path_text)
    if path.is_absolute():
        return path
    return (root / path).resolve()


def _sanitize_token(token: str) -> str:
    token = token.replace('+', 'plus')
    token = re.sub(r'[^A-Za-z0-9_-]+', '_', token)
    return token.strip('_').lower()


def _parse_override(raw_override: str) -> OverrideSpec:
    if '=' not in raw_override:
        raise ValueError(f"Invalid override '{raw_override}' (missing '=')")
    lhs, rhs = raw_override.split('=', 1)
    has_plus = lhs.startswith('+')
    key = lhs.lstrip('+').strip()
    if not key:
        raise ValueError(f"Invalid override '{raw_override}' (empty key)")
    return OverrideSpec(raw=raw_override, key=key, value=rhs.strip(), has_plus=has_plus)


def _config_key_exists(cfg: Any, dotted_key: str) -> bool:
    node = cfg
    for part in dotted_key.split('.'):
        if isinstance(node, DictConfig):
            if part not in node:
                return False
            node = node[part]
            continue
        if isinstance(node, ListConfig):
            if not part.isdigit():
                return False
            idx = int(part)
            if idx < 0 or idx >= len(node):
                return False
            node = node[idx]
            continue
        return False
    return True


def _is_critical_key(key: str, critical_roots: Sequence[str]) -> bool:
    for root in critical_roots:
        if key == root or key.startswith(f'{root}.'):
            return True
    return False


def _normalize_bool(value: str) -> Optional[bool]:
    lowered = value.strip().lower()
    if lowered in {'1', 'true', 'yes', 'on'}:
        return True
    if lowered in {'0', 'false', 'no', 'off'}:
        return False
    return None


def _now_iso() -> str:
    return datetime.now(timezone.utc).isoformat()


def _git_commit(repo_root: Path) -> str:
    try:
        return (
            subprocess.check_output(
                ['git', 'rev-parse', 'HEAD'],
                cwd=repo_root,
                text=True,
                stderr=subprocess.DEVNULL,
            )
            .strip()
        )
    except Exception:
        return 'unknown'


def _config_hash(cfg: DictConfig) -> str:
    payload = OmegaConf.to_container(cfg, resolve=True)
    text = json.dumps(payload, sort_keys=True, separators=(',', ':'))
    return hashlib.sha256(text.encode('utf-8')).hexdigest()


def _effective_dataset_generation_seed(seed: int, split: str) -> int:
    split_name = split.strip()
    if not split_name:
        raise ValueError('Dataset split must be non-empty when deriving generation seed')
    # Deterministically decorrelate train/eval dataset generation for the same base seed.
    seed_payload = f'{int(seed)}::{split_name}'.encode('utf-8')
    seed_hash = hashlib.sha256(seed_payload).digest()
    # Keep in NumPy legacy seeding range [0, 2**32 - 1].
    return int.from_bytes(seed_hash[:8], 'big', signed=False) % (2**32)


def _load_suite_config(config_path: Path) -> Tuple[DictConfig, DictConfig]:
    cfg = OmegaConf.load(str(config_path))
    if not isinstance(cfg, DictConfig):
        raise ValueError(f'Expected DictConfig at {config_path}')
    if 'journal_suite' not in cfg:
        raise ValueError(f"Missing 'journal_suite' key in {config_path}")
    suite = cfg.journal_suite
    if not isinstance(suite, DictConfig):
        raise ValueError("'journal_suite' must be a mapping")
    return cfg, suite


def _compose_validation_base(
    global_cfg: DictConfig,
    settings_dir: Path,
) -> DictConfig:
    with hydra.initialize_config_dir(config_dir=str(settings_dir), version_base=None):
        # Include Hydra's own config tree so strict key validation can verify
        # keys like hydra.run.dir without requiring '+' overrides.
        base_cfg = hydra.compose(config_name='main', return_hydra_config=True)

    simulation_schema = global_cfg.get('simulation', {})
    if simulation_schema:
        with open_dict(base_cfg):
            if 'simulation' not in base_cfg:
                base_cfg.simulation = OmegaConf.create({})
            for key, value in _as_dict(simulation_schema).items():
                base_cfg.simulation[key] = value

    add_simulation_into_config(base_cfg)
    OmegaConf.set_struct(base_cfg, True)
    return base_cfg


def _profile_or_default(suite_cfg: DictConfig, profile_name: Optional[str]) -> Tuple[str, DictConfig]:
    selected = profile_name or str(suite_cfg.default_profile)
    profiles = suite_cfg.get('profiles')
    if profiles is None:
        raise ValueError('Missing journal_suite.profiles')
    if selected not in profiles:
        available = ', '.join(sorted(_as_dict(profiles).keys()))
        raise ValueError(f"Unknown profile '{selected}'. Available: {available}")
    profile_cfg = profiles[selected]
    if not isinstance(profile_cfg, DictConfig):
        raise ValueError(f'Profile {selected} must be a mapping')
    return selected, profile_cfg


def _parse_generalization_cells(profile_cfg: DictConfig) -> List[GeneralizationCell]:
    raw_cells = profile_cfg.get('generalization_cells', [])
    if raw_cells is None:
        return []
    cells: List[GeneralizationCell] = []
    for idx, raw_cell in enumerate(_as_list(raw_cells)):
        cell = _as_dict(raw_cell)
        missing = [
            key
            for key in ('train_scenario', 'eval_scenario', 'topology', 'seed')
            if key not in cell
        ]
        if missing:
            raise ValueError(
                f'generalization_cells[{idx}] missing required key(s): {", ".join(missing)}'
            )
        cells.append(
            GeneralizationCell(
                train_scenario_key=str(cell['train_scenario']),
                eval_scenario_key=str(cell['eval_scenario']),
                topology_key=str(cell['topology']),
                seed=int(cell['seed']),
            )
        )
    return cells


def _validate_profile_matrix_contracts(suite_cfg: DictConfig) -> Dict[str, Any]:
    profiles_cfg = suite_cfg.get('profiles')
    if profiles_cfg is None:
        raise PreflightFailure('Missing journal_suite.profiles')
    available_profiles = set(_as_dict(profiles_cfg).keys())

    missing_profiles = [profile for profile in REQUIRED_PROFILES if profile not in available_profiles]
    if missing_profiles:
        raise PreflightFailure(
            'Missing required profile(s): ' + ', '.join(missing_profiles)
        )

    full_profile_cfg = profiles_cfg['full']
    full_topologies = [str(v) for v in _as_list(full_profile_cfg.topologies)]
    if 'wx500' not in full_topologies:
        raise PreflightFailure(
            "Profile 'full' must include topology 'wx500' to satisfy matrix expansion policy."
        )

    full_generalization_cells = _parse_generalization_cells(full_profile_cfg)
    if len(full_generalization_cells) != 1:
        raise PreflightFailure(
            "Profile 'full' must define exactly one generalization cell in generalization_cells."
        )

    return {
        'required_profiles_present': list(REQUIRED_PROFILES),
        'full_contains_wx500': True,
        'full_generalization_cells': len(full_generalization_cells),
    }


def _build_run_id(
    suite_name: str,
    solver_name: str,
    topology_key: str,
    scenario_key: str,
    seed: int,
    stage: str,
    k_value: int,
    train_token: str,
    eval_token: str,
    offline_token: str,
    is_offline_slice: bool = False,
) -> str:
    solver_token = _sanitize_token(solver_name)
    base = f'{suite_name}__{solver_token}__{topology_key}__{scenario_key}__seed{seed}'
    if stage == 'train':
        if is_offline_slice:
            raise ValueError('Offline slice is only supported for eval stage.')
        return f'{base}{train_token}ktrain{k_value}'
    if stage == 'eval':
        offline_segment = offline_token if is_offline_slice else ''
        return f'{base}{eval_token}{offline_segment}keval{k_value}__ckptlatest'
    raise ValueError(f'Unsupported stage {stage}')


def _build_dataset_dir(
    dataset_root: Path,
    scenario_key: str,
    topology_key: str,
    seed: int,
    split: str,
) -> Path:
    return dataset_root / scenario_key / topology_key / f'seed_{seed}' / split


def _build_offline_dataset_dir(base_dataset_dir: Path, suffix: str) -> Path:
    suffix_token = suffix.strip()
    if not suffix_token:
        raise ValueError('offline_slice.conversion.dataset_suffix must be non-empty')
    return base_dataset_dir.parent / f'{base_dataset_dir.name}__{_sanitize_token(suffix_token)}'


def _build_job_overrides(
    suite_cfg: DictConfig,
    profile_cfg: Optional[DictConfig],
    save_root: Path,
    stage: str,
    solver_name: str,
    seed: int,
    k_value: int,
    run_id: str,
    dataset_dir: Path,
    method_cfg: Optional[DictConfig] = None,
    topology_cfg: Optional[DictConfig] = None,
    scenario_cfg: Optional[DictConfig] = None,
    is_offline_system: bool = False,
) -> List[str]:
    overrides_cfg = suite_cfg.overrides
    common = [str(v) for v in _as_list(overrides_cfg.common)]
    fixed_dataset = [str(v) for v in _as_list(overrides_cfg.fixed_dataset)]
    stage_overrides = [str(v) for v in _as_list(overrides_cfg[stage])]
    profile_common: List[str] = []
    profile_stage_overrides: List[str] = []
    if profile_cfg is not None and 'overrides' in profile_cfg:
        profile_overrides_cfg = profile_cfg.overrides
        if 'common' in profile_overrides_cfg:
            profile_common = [str(v) for v in _as_list(profile_overrides_cfg.common)]
        if stage in profile_overrides_cfg:
            profile_stage_overrides = [str(v) for v in _as_list(profile_overrides_cfg[stage])]

    method_common: List[str] = []
    method_stage_overrides: List[str] = []
    if method_cfg is not None and 'overrides' in method_cfg:
        method_overrides_cfg = method_cfg.overrides
        if 'common' in method_overrides_cfg:
            method_common = [str(v) for v in _as_list(method_overrides_cfg.common)]
        if stage in method_overrides_cfg:
            method_stage_overrides = [str(v) for v in _as_list(method_overrides_cfg[stage])]

    topology_common: List[str] = []
    topology_stage_overrides: List[str] = []
    if topology_cfg is not None and 'overrides' in topology_cfg:
        topology_overrides_cfg = topology_cfg.overrides
        if 'common' in topology_overrides_cfg:
            topology_common = [str(v) for v in _as_list(topology_overrides_cfg.common)]
        if stage in topology_overrides_cfg:
            topology_stage_overrides = [str(v) for v in _as_list(topology_overrides_cfg[stage])]

    scenario_common: List[str] = []
    if scenario_cfg is not None:
        p_net_overrides = scenario_cfg.get('p_net_setting_overrides')
        if p_net_overrides is not None:
            scenario_common.extend(
                _flatten_override_mapping('p_net_setting', _as_dict(p_net_overrides))
            )
        v_sim_overrides = scenario_cfg.get('v_sim_setting_overrides')
        if v_sim_overrides is not None:
            scenario_common.extend(
                _flatten_override_mapping('v_sim_setting', _as_dict(v_sim_overrides))
            )

    hydra_dir = save_root / solver_name / run_id / 'hydra'
    job_specific = [
        f'solver.solver_name={solver_name}',
        f'solver.k_shortest={k_value}',
        f'experiment.seed={seed}',
        f'training.seed={seed}',
        f'experiment.run_id={run_id}',
        f'experiment.save_root_dir={save_root}',
        f'hydra.run.dir={hydra_dir}',
        f'simulation.p_net_dataset_dir={dataset_dir}',
        f'simulation.v_nets_dataset_dir={dataset_dir}',
    ]
    if is_offline_system:
        job_specific.append('system.if_offline_system=true')

    overrides = [
        *common,
        *fixed_dataset,
        *stage_overrides,
        *method_common,
        *method_stage_overrides,
        *scenario_common,
        *profile_common,
        *profile_stage_overrides,
        *topology_common,
        *topology_stage_overrides,
        *job_specific,
    ]

    # Ensure AlphaZero-SFC uses the C++ backend by default and stops workers once
    # learner finishes, but respect explicit caller overrides.
    if solver_name == 'alpha_zero_sfc':
        def _has_override_key(items: list[str], key: str) -> bool:
            return any(str(item).split('=', 1)[0].strip() == key for item in items)

        default_overrides = (
            ('training.use_cpp_mcts', 'training.use_cpp_mcts=true'),
            ('training.pure_cpp', 'training.pure_cpp=true'),
            (
                'training.signal_stop_event_on_learner_complete',
                'training.signal_stop_event_on_learner_complete=true',
            ),
        )
        for key, entry in default_overrides:
            if not _has_override_key(overrides, key):
                overrides.append(entry)

    return overrides


def _resolve_offline_slice_plan(
    suite_cfg: DictConfig,
    profile_cfg: DictConfig,
) -> OfflineSlicePlan:
    offline_cfg = suite_cfg.get('offline_slice')
    if offline_cfg is None or not bool(offline_cfg.get('enabled', False)):
        return OfflineSlicePlan(
            enabled=False,
            method_keys=tuple(),
            topology_keys=tuple(),
            scenario_keys=tuple(),
            seeds=tuple(),
            k_eval_values=tuple(),
            conversion_enabled=False,
            dataset_suffix='offline',
        )

    profile_method_keys = [str(v) for v in _as_list(profile_cfg.methods)]
    profile_topology_keys = [str(v) for v in _as_list(profile_cfg.topologies)]
    profile_scenario_keys = [str(v) for v in _as_list(profile_cfg.scenarios)]
    profile_seeds = [int(v) for v in _as_list(profile_cfg.seeds)]
    profile_k_eval_values = [int(v) for v in _as_list(profile_cfg.k_eval_values)]

    raw_method_keys = offline_cfg.get('method_keys')
    raw_topology_keys = offline_cfg.get('topologies')
    raw_scenario_keys = offline_cfg.get('scenarios')
    raw_seeds = offline_cfg.get('seeds')
    raw_k_eval_values = offline_cfg.get('k_eval_values')

    method_keys = [str(v) for v in _as_list(raw_method_keys)] if raw_method_keys is not None else profile_method_keys[:1]
    topology_keys = [str(v) for v in _as_list(raw_topology_keys)] if raw_topology_keys is not None else profile_topology_keys[:1]
    scenario_keys = [str(v) for v in _as_list(raw_scenario_keys)] if raw_scenario_keys is not None else profile_scenario_keys[:1]
    seeds = [int(v) for v in _as_list(raw_seeds)] if raw_seeds is not None else profile_seeds[:1]
    k_eval_values = [int(v) for v in _as_list(raw_k_eval_values)] if raw_k_eval_values is not None else profile_k_eval_values[:1]

    if not method_keys:
        raise ValueError('offline_slice.enabled=true requires at least one method key')
    if not topology_keys:
        raise ValueError('offline_slice.enabled=true requires at least one topology key')
    if not scenario_keys:
        raise ValueError('offline_slice.enabled=true requires at least one scenario key')
    if not seeds:
        raise ValueError('offline_slice.enabled=true requires at least one seed')
    if not k_eval_values:
        raise ValueError('offline_slice.enabled=true requires at least one k_eval value')

    unknown_methods = sorted(set(method_keys) - set(profile_method_keys))
    if unknown_methods:
        raise ValueError(
            'offline_slice.method_keys must be subset of profile.methods; unknown: '
            + ', '.join(unknown_methods)
        )
    unknown_topologies = sorted(set(topology_keys) - set(profile_topology_keys))
    if unknown_topologies:
        raise ValueError(
            'offline_slice.topologies must be subset of profile.topologies; unknown: '
            + ', '.join(unknown_topologies)
        )
    unknown_scenarios = sorted(set(scenario_keys) - set(profile_scenario_keys))
    if unknown_scenarios:
        raise ValueError(
            'offline_slice.scenarios must be subset of profile.scenarios; unknown: '
            + ', '.join(unknown_scenarios)
        )
    unknown_seeds = sorted(set(seeds) - set(profile_seeds))
    if unknown_seeds:
        raise ValueError(
            'offline_slice.seeds must be subset of profile.seeds; unknown: '
            + ', '.join(str(v) for v in unknown_seeds)
        )
    unknown_k = sorted(set(k_eval_values) - set(profile_k_eval_values))
    if unknown_k:
        raise ValueError(
            'offline_slice.k_eval_values must be subset of profile.k_eval_values; unknown: '
            + ', '.join(str(v) for v in unknown_k)
        )

    conversion_cfg = offline_cfg.get('conversion', OmegaConf.create({}))
    conversion_enabled = bool(conversion_cfg.get('enabled', True))
    dataset_suffix = str(conversion_cfg.get('dataset_suffix', 'offline')).strip()
    if not dataset_suffix:
        raise ValueError('offline_slice.conversion.dataset_suffix must be non-empty')

    return OfflineSlicePlan(
        enabled=True,
        method_keys=tuple(method_keys),
        topology_keys=tuple(topology_keys),
        scenario_keys=tuple(scenario_keys),
        seeds=tuple(seeds),
        k_eval_values=tuple(k_eval_values),
        conversion_enabled=conversion_enabled,
        dataset_suffix=dataset_suffix,
    )


def _offline_slice_dataset_selector(
    suite_cfg: DictConfig,
    profile_cfg: DictConfig,
) -> Tuple[set[Tuple[str, str, int, str]], str]:
    plan = _resolve_offline_slice_plan(suite_cfg, profile_cfg)
    if not plan.enabled:
        return set(), 'offline'

    selectors: set[Tuple[str, str, int, str]] = set()
    scenarios_cfg = suite_cfg.scenarios
    for topology_key in plan.topology_keys:
        for scenario_key in plan.scenario_keys:
            scenario_cfg = scenarios_cfg[scenario_key]
            eval_split = str(scenario_cfg.eval_split)
            for seed in plan.seeds:
                selectors.add((scenario_key, topology_key, seed, eval_split))
    return selectors, plan.dataset_suffix


def _build_planned_jobs(
    suite_cfg: DictConfig,
    profile_cfg: DictConfig,
    repo_root: Path,
) -> List[PlannedJob]:
    suite_name = str(suite_cfg.name)
    dataset_root = _resolve_path(str(suite_cfg.paths.dataset_root), repo_root)
    save_root = _resolve_path(str(suite_cfg.paths.save_root_dir), repo_root)
    methods_cfg = suite_cfg.methods
    topologies_cfg = suite_cfg.topologies
    scenarios_cfg = suite_cfg.scenarios
    train_token = str(suite_cfg.safety.run_id_tokens.train)
    eval_token = str(suite_cfg.safety.run_id_tokens.eval)
    offline_token = str(suite_cfg.safety.run_id_tokens.get('offline', '__offline__'))

    method_keys = [str(v) for v in _as_list(profile_cfg.methods)]
    topology_keys = [str(v) for v in _as_list(profile_cfg.topologies)]
    scenario_keys = [str(v) for v in _as_list(profile_cfg.scenarios)]
    seeds = [int(v) for v in _as_list(profile_cfg.seeds)]
    k_eval_values = [int(v) for v in _as_list(profile_cfg.k_eval_values)]
    offline_plan = _resolve_offline_slice_plan(suite_cfg, profile_cfg)
    generalization_cells = _parse_generalization_cells(profile_cfg)

    for scenario_key in scenario_keys:
        if scenario_key not in scenarios_cfg:
            raise ValueError(f"Scenario '{scenario_key}' missing from journal_suite.scenarios")

    for cell in generalization_cells:
        if cell.train_scenario_key not in scenarios_cfg:
            raise ValueError(
                f"Generalization cell references unknown train scenario "
                f"'{cell.train_scenario_key}'"
            )
        if cell.eval_scenario_key not in scenarios_cfg:
            raise ValueError(
                f"Generalization cell references unknown eval scenario "
                f"'{cell.eval_scenario_key}'"
            )
        if cell.topology_key not in topologies_cfg:
            raise ValueError(
                f"Generalization cell references unknown topology '{cell.topology_key}'"
            )
        if cell.topology_key not in topology_keys:
            raise ValueError(
                f"Generalization cell topology '{cell.topology_key}' must be included in "
                'profile.topologies'
            )
        if cell.seed not in seeds:
            raise ValueError(
                f"Generalization cell seed '{cell.seed}' must be included in profile.seeds"
            )

    jobs: List[PlannedJob] = []
    for method_key in method_keys:
        if method_key not in methods_cfg:
            raise ValueError(f"Method '{method_key}' missing from journal_suite.methods")
        method_cfg = methods_cfg[method_key]
        solver_name = str(method_cfg.solver_name)
        trainable = bool(method_cfg.get('trainable', False))
        train_k_values = [int(v) for v in _as_list(method_cfg.get('train_k_values', []))]

        for topology_key in topology_keys:
            if topology_key not in topologies_cfg:
                raise ValueError(f"Topology '{topology_key}' missing from journal_suite.topologies")
            topology_cfg = topologies_cfg[topology_key]
            topology_file = _resolve_path(str(topology_cfg.file_path), repo_root)

            for scenario_key in scenario_keys:
                scenario_cfg = scenarios_cfg[scenario_key]
                train_split = str(scenario_cfg.train_split)
                eval_split = str(scenario_cfg.eval_split)

                for seed in seeds:
                    if trainable:
                        for k_train in train_k_values:
                            run_id = _build_run_id(
                                suite_name=suite_name,
                                solver_name=solver_name,
                                topology_key=topology_key,
                                scenario_key=scenario_key,
                                seed=seed,
                                stage='train',
                                k_value=k_train,
                                train_token=train_token,
                                eval_token=eval_token,
                                offline_token=offline_token,
                                is_offline_slice=False,
                            )
                            dataset_dir = _build_dataset_dir(
                                dataset_root=dataset_root,
                                scenario_key=scenario_key,
                                topology_key=topology_key,
                                seed=seed,
                                split=train_split,
                            )
                            overrides = _build_job_overrides(
                                suite_cfg=suite_cfg,
                                profile_cfg=profile_cfg,
                                save_root=save_root,
                                stage='train',
                                solver_name=solver_name,
                                seed=seed,
                                k_value=k_train,
                                run_id=run_id,
                                dataset_dir=dataset_dir,
                                method_cfg=method_cfg,
                                topology_cfg=topology_cfg,
                                scenario_cfg=scenario_cfg,
                                is_offline_system=False,
                            )
                            jobs.append(
                                PlannedJob(
                                    stage='train',
                                    method_key=method_key,
                                    solver_name=solver_name,
                                    topology_key=topology_key,
                                    scenario_key=scenario_key,
                                    dataset_scenario_key=scenario_key,
                                    train_source_scenario_key=None,
                                    seed=seed,
                                    k_value=k_train,
                                    run_id=run_id,
                                    dataset_dir=str(dataset_dir),
                                    source_dataset_dir=None,
                                    is_offline_slice=False,
                                    topology_file_path=str(topology_file),
                                    overrides=tuple(overrides),
                                )
                            )

                    for k_eval in k_eval_values:
                        run_id = _build_run_id(
                            suite_name=suite_name,
                            solver_name=solver_name,
                            topology_key=topology_key,
                            scenario_key=scenario_key,
                            seed=seed,
                            stage='eval',
                            k_value=k_eval,
                            train_token=train_token,
                            eval_token=eval_token,
                            offline_token=offline_token,
                            is_offline_slice=False,
                        )
                        dataset_dir = _build_dataset_dir(
                            dataset_root=dataset_root,
                            scenario_key=scenario_key,
                            topology_key=topology_key,
                            seed=seed,
                            split=eval_split,
                        )
                        overrides = _build_job_overrides(
                            suite_cfg=suite_cfg,
                            profile_cfg=profile_cfg,
                            save_root=save_root,
                            stage='eval',
                            solver_name=solver_name,
                            seed=seed,
                            k_value=k_eval,
                            run_id=run_id,
                            dataset_dir=dataset_dir,
                            method_cfg=method_cfg,
                            topology_cfg=topology_cfg,
                            scenario_cfg=scenario_cfg,
                            is_offline_system=False,
                        )
                        jobs.append(
                            PlannedJob(
                                stage='eval',
                                method_key=method_key,
                                solver_name=solver_name,
                                topology_key=topology_key,
                                scenario_key=scenario_key,
                                dataset_scenario_key=scenario_key,
                                train_source_scenario_key=None,
                                seed=seed,
                                k_value=k_eval,
                                run_id=run_id,
                                dataset_dir=str(dataset_dir),
                                source_dataset_dir=None,
                                is_offline_slice=False,
                                topology_file_path=str(topology_file),
                                overrides=tuple(overrides),
                            )
                        )

        for cell in generalization_cells:
            eval_scenario_cfg = scenarios_cfg[cell.eval_scenario_key]
            eval_split = str(eval_scenario_cfg.eval_split)
            scenario_key = _sanitize_token(
                f'{cell.train_scenario_key}_to_{cell.eval_scenario_key}'
            )
            topology_file = _resolve_path(
                str(topologies_cfg[cell.topology_key].file_path),
                repo_root,
            )
            topology_cfg = topologies_cfg[cell.topology_key]

            for k_eval in k_eval_values:
                run_id = _build_run_id(
                    suite_name=suite_name,
                    solver_name=solver_name,
                    topology_key=cell.topology_key,
                    scenario_key=scenario_key,
                    seed=cell.seed,
                    stage='eval',
                    k_value=k_eval,
                    train_token=train_token,
                    eval_token=eval_token,
                    offline_token=offline_token,
                    is_offline_slice=False,
                )
                dataset_dir = _build_dataset_dir(
                    dataset_root=dataset_root,
                    scenario_key=cell.eval_scenario_key,
                    topology_key=cell.topology_key,
                    seed=cell.seed,
                    split=eval_split,
                )
                overrides = _build_job_overrides(
                    suite_cfg=suite_cfg,
                    profile_cfg=profile_cfg,
                    save_root=save_root,
                    stage='eval',
                    solver_name=solver_name,
                    seed=cell.seed,
                    k_value=k_eval,
                    run_id=run_id,
                    dataset_dir=dataset_dir,
                    method_cfg=method_cfg,
                    topology_cfg=topology_cfg,
                    scenario_cfg=eval_scenario_cfg,
                    is_offline_system=False,
                )
                jobs.append(
                    PlannedJob(
                        stage='eval',
                        method_key=method_key,
                        solver_name=solver_name,
                        topology_key=cell.topology_key,
                        scenario_key=scenario_key,
                        dataset_scenario_key=cell.eval_scenario_key,
                        train_source_scenario_key=cell.train_scenario_key,
                        seed=cell.seed,
                        k_value=k_eval,
                        run_id=run_id,
                        dataset_dir=str(dataset_dir),
                        source_dataset_dir=None,
                        is_offline_slice=False,
                        topology_file_path=str(topology_file),
                        overrides=tuple(overrides),
                    )
                )

    if offline_plan.enabled:
        for method_key in offline_plan.method_keys:
            method_cfg = methods_cfg[method_key]
            solver_name = str(method_cfg.solver_name)
            for topology_key in offline_plan.topology_keys:
                topology_cfg = topologies_cfg[topology_key]
                topology_file = _resolve_path(str(topology_cfg.file_path), repo_root)
                for scenario_key in offline_plan.scenario_keys:
                    scenario_cfg = scenarios_cfg[scenario_key]
                    eval_split = str(scenario_cfg.eval_split)
                    for seed in offline_plan.seeds:
                        source_dataset_dir = _build_dataset_dir(
                            dataset_root=dataset_root,
                            scenario_key=scenario_key,
                            topology_key=topology_key,
                            seed=seed,
                            split=eval_split,
                        )
                        offline_dataset_dir = _build_offline_dataset_dir(
                            source_dataset_dir,
                            suffix=offline_plan.dataset_suffix,
                        )
                        for k_eval in offline_plan.k_eval_values:
                            run_id = _build_run_id(
                                suite_name=suite_name,
                                solver_name=solver_name,
                                topology_key=topology_key,
                                scenario_key=scenario_key,
                                seed=seed,
                                stage='eval',
                                k_value=k_eval,
                                train_token=train_token,
                                eval_token=eval_token,
                                offline_token=offline_token,
                                is_offline_slice=True,
                            )
                            overrides = _build_job_overrides(
                                suite_cfg=suite_cfg,
                                profile_cfg=profile_cfg,
                                save_root=save_root,
                                stage='eval',
                                solver_name=solver_name,
                                seed=seed,
                                k_value=k_eval,
                                run_id=run_id,
                                dataset_dir=offline_dataset_dir,
                                method_cfg=method_cfg,
                                topology_cfg=topology_cfg,
                                scenario_cfg=scenario_cfg,
                                is_offline_system=True,
                            )
                            jobs.append(
                                PlannedJob(
                                    stage='eval',
                                    method_key=method_key,
                                    solver_name=solver_name,
                                    topology_key=topology_key,
                                    scenario_key=scenario_key,
                                    dataset_scenario_key=scenario_key,
                                    train_source_scenario_key=None,
                                    seed=seed,
                                    k_value=k_eval,
                                    run_id=run_id,
                                    dataset_dir=str(offline_dataset_dir),
                                    source_dataset_dir=str(source_dataset_dir),
                                    is_offline_slice=True,
                                    topology_file_path=str(topology_file),
                                    overrides=tuple(overrides),
                                )
                            )
    return jobs


def _build_dataset_specs(
    suite_cfg: DictConfig,
    profile_cfg: DictConfig,
    repo_root: Path,
) -> List[DatasetSpec]:
    dataset_root = _resolve_path(str(suite_cfg.paths.dataset_root), repo_root)
    topologies_cfg = suite_cfg.topologies
    scenarios_cfg = suite_cfg.scenarios

    topology_keys = [str(v) for v in _as_list(profile_cfg.topologies)]
    scenario_keys = [str(v) for v in _as_list(profile_cfg.scenarios)]
    seeds = [int(v) for v in _as_list(profile_cfg.seeds)]
    generalization_cells = _parse_generalization_cells(profile_cfg)

    specs: List[DatasetSpec] = []
    seen: set[Tuple[str, str, int, str]] = set()

    for scenario_key in scenario_keys:
        if scenario_key not in scenarios_cfg:
            raise ValueError(f"Scenario '{scenario_key}' missing from journal_suite.scenarios")

    def _add_spec(
        scenario_key: str,
        topology_key: str,
        topology_file_path: str,
        seed: int,
        split: str,
    ) -> None:
        split_name = split.strip()
        if not split_name:
            raise ValueError(
                f"Scenario '{scenario_key}' has an empty split name (train_split/eval_split)."
            )
        key = (scenario_key, topology_key, seed, split_name)
        if key in seen:
            return
        seen.add(key)
        dataset_dir = _build_dataset_dir(
            dataset_root=dataset_root,
            scenario_key=scenario_key,
            topology_key=topology_key,
            seed=seed,
            split=split_name,
        )
        specs.append(
            DatasetSpec(
                scenario_key=scenario_key,
                topology_key=topology_key,
                seed=seed,
                split=split_name,
                dataset_dir=str(dataset_dir),
                topology_file_path=topology_file_path,
            )
        )

    for topology_key in topology_keys:
        if topology_key not in topologies_cfg:
            raise ValueError(f"Topology '{topology_key}' missing from journal_suite.topologies")
        topology_file = str(_resolve_path(str(topologies_cfg[topology_key].file_path), repo_root))

        for scenario_key in scenario_keys:
            scenario_cfg = scenarios_cfg[scenario_key]
            for seed in seeds:
                _add_spec(
                    scenario_key=scenario_key,
                    topology_key=topology_key,
                    topology_file_path=topology_file,
                    seed=seed,
                    split=str(scenario_cfg.train_split),
                )
                _add_spec(
                    scenario_key=scenario_key,
                    topology_key=topology_key,
                    topology_file_path=topology_file,
                    seed=seed,
                    split=str(scenario_cfg.eval_split),
                )

    for cell in generalization_cells:
        if cell.train_scenario_key not in scenarios_cfg:
            raise ValueError(
                f"Generalization cell references unknown train scenario "
                f"'{cell.train_scenario_key}'"
            )
        if cell.eval_scenario_key not in scenarios_cfg:
            raise ValueError(
                f"Generalization cell references unknown eval scenario "
                f"'{cell.eval_scenario_key}'"
            )
        if cell.topology_key not in topologies_cfg:
            raise ValueError(
                f"Generalization cell references unknown topology '{cell.topology_key}'"
            )
        if cell.topology_key not in topology_keys:
            raise ValueError(
                f"Generalization cell topology '{cell.topology_key}' must be included in "
                'profile.topologies'
            )
        if cell.seed not in seeds:
            raise ValueError(
                f"Generalization cell seed '{cell.seed}' must be included in profile.seeds"
            )

        topology_file = str(_resolve_path(str(topologies_cfg[cell.topology_key].file_path), repo_root))
        train_scenario_cfg = scenarios_cfg[cell.train_scenario_key]
        eval_scenario_cfg = scenarios_cfg[cell.eval_scenario_key]

        # Guarantee the train split used by the generalization checkpoint exists.
        _add_spec(
            scenario_key=cell.train_scenario_key,
            topology_key=cell.topology_key,
            topology_file_path=topology_file,
            seed=cell.seed,
            split=str(train_scenario_cfg.train_split),
        )
        # Explicitly add the shifted eval split for the generalization cell.
        _add_spec(
            scenario_key=cell.eval_scenario_key,
            topology_key=cell.topology_key,
            topology_file_path=topology_file,
            seed=cell.seed,
            split=str(eval_scenario_cfg.eval_split),
        )
    return specs


def _validate_dataset_topologies_exist(specs: Sequence[DatasetSpec]) -> None:
    missing: List[str] = []
    for path_text in sorted({spec.topology_file_path for spec in specs}):
        if not Path(path_text).exists():
            missing.append(path_text)
    if missing:
        raise PreflightFailure('Missing topology files:\n' + '\n'.join(missing))


def _build_dataset_generation_config(
    validation_cfg: DictConfig,
    dataset_spec: DatasetSpec,
    scenario_cfg: DictConfig,
) -> DictConfig:
    cfg = copy.deepcopy(validation_cfg)
    with open_dict(cfg):
        cfg.experiment.seed = dataset_spec.seed
        if 'training' in cfg and 'seed' in cfg.training:
            cfg.training.seed = dataset_spec.seed
        cfg.use_fixed_dataset = True
        cfg.experiment.if_load_p_net = True
        cfg.experiment.if_load_v_nets = True
        cfg.simulation.p_net_dataset_dir = dataset_spec.dataset_dir
        cfg.simulation.v_nets_dataset_dir = dataset_spec.dataset_dir
        cfg.p_net_setting.topology.file_path = dataset_spec.topology_file_path
        cfg.p_net_setting.output.save_dir = dataset_spec.dataset_dir
        cfg.v_sim_setting.output.save_dir = dataset_spec.dataset_dir

        p_net_overrides = scenario_cfg.get('p_net_setting_overrides')
        if p_net_overrides is not None:
            cfg.p_net_setting = OmegaConf.merge(
                cfg.p_net_setting,
                OmegaConf.create(_as_dict(p_net_overrides)),
            )

        v_sim_overrides = scenario_cfg.get('v_sim_setting_overrides')
        if v_sim_overrides is not None:
            cfg.v_sim_setting = OmegaConf.merge(
                cfg.v_sim_setting,
                OmegaConf.create(_as_dict(v_sim_overrides)),
            )

    add_simulation_into_config(cfg)
    return cfg


def _write_dataset_config_snapshot(
    dataset_spec: DatasetSpec,
    generation_cfg: DictConfig,
    dataset_dir: Path,
    generation_seed: int,
) -> None:
    dataset_dir.mkdir(parents=True, exist_ok=True)
    snapshot = OmegaConf.create(
        {
            'generated_at_utc': _now_iso(),
            'scenario': dataset_spec.scenario_key,
            'topology': dataset_spec.topology_key,
            'split': dataset_spec.split,
            'seed': dataset_spec.seed,
            'generation_seed': int(generation_seed),
            'topology_file_path': dataset_spec.topology_file_path,
            'dataset_dir': str(dataset_dir),
            'experiment': {
                'seed': int(generation_cfg.experiment.seed),
                'if_load_p_net': bool(generation_cfg.experiment.if_load_p_net),
                'if_load_v_nets': bool(generation_cfg.experiment.if_load_v_nets),
            },
            'simulation': {
                'p_net_dataset_dir': str(generation_cfg.simulation.p_net_dataset_dir),
                'v_nets_dataset_dir': str(generation_cfg.simulation.v_nets_dataset_dir),
            },
            'p_net_setting': OmegaConf.to_container(generation_cfg.p_net_setting, resolve=True),
            'v_sim_setting': OmegaConf.to_container(generation_cfg.v_sim_setting, resolve=True),
        }
    )
    OmegaConf.save(snapshot, str(dataset_dir / 'config_snapshot.yaml'))


def _validate_event_stream_integrity(dataset_dir: Path) -> Dict[str, Any]:
    events_path = dataset_dir / 'events.yaml'
    if not events_path.exists():
        raise PreflightFailure(f'{dataset_dir}: missing events.yaml')

    raw_events = read_setting(str(events_path), mode='r+')
    if not isinstance(raw_events, list) or not raw_events:
        raise PreflightFailure(f'{dataset_dir}: events.yaml must contain a non-empty list')

    v_nets_dir = dataset_dir / 'v_nets'
    if not v_nets_dir.exists() or not v_nets_dir.is_dir():
        raise PreflightFailure(f'{dataset_dir}: missing v_nets directory')
    v_net_files = sorted(v_nets_dir.glob('*.gml'))
    if not v_net_files:
        raise PreflightFailure(f'{dataset_dir}: v_nets directory is empty')

    arrivals: Dict[int, int] = {}
    departures: Dict[int, int] = {}
    arrival_times: Dict[int, float] = {}
    departure_times: Dict[int, float] = {}
    previous_time: Optional[float] = None

    for idx, event in enumerate(raw_events):
        if not isinstance(event, dict):
            raise PreflightFailure(f'{dataset_dir}: event #{idx} is not a mapping')
        missing_keys = [key for key in ('id', 'type', 'v_net_id', 'time') if key not in event]
        if missing_keys:
            raise PreflightFailure(
                f"{dataset_dir}: event #{idx} missing keys {', '.join(missing_keys)}"
            )

        try:
            event_id = int(event['id'])
            event_type = int(event['type'])
            v_net_id = int(event['v_net_id'])
            event_time = float(event['time'])
        except (TypeError, ValueError) as exc:
            raise PreflightFailure(f'{dataset_dir}: malformed event #{idx}: {exc}') from exc

        if event_id != idx:
            raise PreflightFailure(
                f'{dataset_dir}: event id ordering mismatch at index {idx} (id={event_id})'
            )
        if event_type not in (0, 1):
            raise PreflightFailure(f'{dataset_dir}: invalid event type {event_type} at index {idx}')
        if previous_time is not None and event_time < previous_time:
            raise PreflightFailure(
                f'{dataset_dir}: event time decreased at index {idx} '
                f'({event_time} < {previous_time})'
            )
        previous_time = event_time

        if event_type == 1:
            arrivals[v_net_id] = arrivals.get(v_net_id, 0) + 1
            arrival_times[v_net_id] = event_time
        else:
            departures[v_net_id] = departures.get(v_net_id, 0) + 1
            departure_times[v_net_id] = event_time

    v_net_ids = sorted(set(arrivals) | set(departures))
    invalid_pairs = [
        v_net_id
        for v_net_id in v_net_ids
        if arrivals.get(v_net_id, 0) != 1 or departures.get(v_net_id, 0) != 1
    ]
    if invalid_pairs:
        preview = ', '.join(str(v_id) for v_id in invalid_pairs[:10])
        raise PreflightFailure(
            f'{dataset_dir}: arrival/departure pairing violation for v_net_id(s): {preview}'
        )
    for v_net_id in v_net_ids:
        if departure_times[v_net_id] < arrival_times[v_net_id]:
            raise PreflightFailure(
                f'{dataset_dir}: departure precedes arrival for v_net_id={v_net_id} '
                f"({departure_times[v_net_id]} < {arrival_times[v_net_id]})"
            )

    num_requests = len(v_net_ids)
    num_events = len(raw_events)
    if num_events != 2 * num_requests:
        raise PreflightFailure(
            f'{dataset_dir}: expected exactly two events per request '
            f'(events={num_events}, requests={num_requests})'
        )
    if len(v_net_files) != num_requests:
        raise PreflightFailure(
            f'{dataset_dir}: v_nets file count mismatch '
            f'(files={len(v_net_files)}, requests={num_requests})'
        )

    return {
        'events_file': str(events_path),
        'v_nets_dir': str(v_nets_dir),
        'num_events': num_events,
        'num_requests': num_requests,
        'num_arrivals': sum(arrivals.values()),
        'num_departures': sum(departures.values()),
        'v_nets_file_count': len(v_net_files),
        'time_non_decreasing': True,
        'arrival_departure_pairing': True,
        'two_events_per_request': True,
    }


def _materialize_dataset(
    dataset_spec: DatasetSpec,
    generation_cfg: DictConfig,
    force: bool,
) -> Dict[str, Any]:
    dataset_dir = Path(dataset_spec.dataset_dir)
    existed_before = dataset_dir.exists()
    if existed_before and not dataset_dir.is_dir():
        raise PreflightFailure(f'{dataset_dir} exists but is not a directory')

    if existed_before and force:
        shutil.rmtree(dataset_dir)

    generation_seed = _effective_dataset_generation_seed(
        seed=dataset_spec.seed,
        split=dataset_spec.split,
    )
    regeneration_reason: Optional[str] = None
    if dataset_dir.exists() and not force:
        metadata_path = dataset_dir / 'generation_metadata.json'
        existing_generation_seed: Optional[int] = None
        if metadata_path.exists():
            try:
                metadata = json.loads(metadata_path.read_text(encoding='utf-8'))
                existing_seed_raw = metadata.get('generation_seed')
                if existing_seed_raw is not None:
                    existing_generation_seed = int(existing_seed_raw)
            except Exception:
                existing_generation_seed = None
        if existing_generation_seed is None:
            regeneration_reason = 'missing_or_invalid_generation_seed_metadata'
        elif existing_generation_seed != int(generation_seed):
            regeneration_reason = (
                f'generation_seed_mismatch:{existing_generation_seed}->{int(generation_seed)}'
            )
        if regeneration_reason is not None:
            shutil.rmtree(dataset_dir)

    generated_now = False
    if not dataset_dir.exists():
        dataset_dir.mkdir(parents=True, exist_ok=True)

        p_net = PhysicalNetwork.from_setting(
            generation_cfg.p_net_setting,
            seed=generation_seed,
        )
        p_net.save_dataset(str(dataset_dir))

        v_simulator = VirtualNetworkRequestSimulator.from_setting(
            generation_cfg.v_sim_setting,
            seed=generation_seed,
        )
        v_simulator.renew(v_nets=True, events=True, seed=generation_seed)
        v_simulator.save_dataset(str(dataset_dir))
        generated_now = True

    checks = _validate_event_stream_integrity(dataset_dir)
    _write_dataset_config_snapshot(
        dataset_spec=dataset_spec,
        generation_cfg=generation_cfg,
        dataset_dir=dataset_dir,
        generation_seed=generation_seed,
    )

    config_hash_input = OmegaConf.create(
        {
            'scenario': dataset_spec.scenario_key,
            'topology': dataset_spec.topology_key,
            'split': dataset_spec.split,
            'seed': dataset_spec.seed,
            'generation_seed': int(generation_seed),
            'topology_file_path': dataset_spec.topology_file_path,
            'p_net_setting': OmegaConf.to_container(generation_cfg.p_net_setting, resolve=True),
            'v_sim_setting': OmegaConf.to_container(generation_cfg.v_sim_setting, resolve=True),
        }
    )
    status = 'reused'
    if generated_now and (force and existed_before):
        status = 'regenerated'
    elif generated_now and regeneration_reason is not None:
        status = 'regenerated'
    elif generated_now:
        status = 'generated'

    metadata = {
        'generated_at_utc': _now_iso(),
        'git_commit': _git_commit(REPO_ROOT),
        'scenario': dataset_spec.scenario_key,
        'topology': dataset_spec.topology_key,
        'split': dataset_spec.split,
        'seed': dataset_spec.seed,
        'generation_seed': int(generation_seed),
        'dataset_dir': str(dataset_dir),
        'topology_file_path': dataset_spec.topology_file_path,
        'status': status,
        'force': bool(force),
        'regeneration_reason': regeneration_reason or '',
        'config_snapshot': str(dataset_dir / 'config_snapshot.yaml'),
        'dataset_config_sha256': _config_hash(config_hash_input),
        'event_checks': checks,
    }
    with (dataset_dir / 'generation_metadata.json').open('w', encoding='utf-8') as f:
        json.dump(metadata, f, indent=2, sort_keys=True)
    return metadata


def _validate_topologies_exist(jobs: Sequence[PlannedJob]) -> None:
    missing: List[str] = []
    for path_text in sorted({job.topology_file_path for job in jobs}):
        if not Path(path_text).exists():
            missing.append(path_text)
    if missing:
        raise PreflightFailure('Missing topology files:\n' + '\n'.join(missing))


def _validate_solver_names(suite_cfg: DictConfig, profile_cfg: DictConfig) -> None:
    method_keys = [str(v) for v in _as_list(profile_cfg.methods)]
    methods_cfg = suite_cfg.methods
    registered = set(SolverRegistry.list_registered().keys())
    missing: List[str] = []
    for method_key in method_keys:
        method_cfg = methods_cfg[method_key]
        solver_name = str(method_cfg.solver_name)
        if solver_name not in registered:
            missing.append(f'{method_key} -> {solver_name}')
    if missing:
        raise PreflightFailure(
            'Unavailable solver registrations for selected profile:\n' + '\n'.join(missing)
        )


def _validate_override_policy(
    jobs: Sequence[PlannedJob],
    validation_cfg: DictConfig,
    safety_cfg: DictConfig,
) -> Dict[str, Dict[str, str]]:
    critical_roots = [str(v) for v in _as_list(safety_cfg.critical_override_roots)]
    required_fixed_dataset_keys = [str(v) for v in _as_list(safety_cfg.required_fixed_dataset_keys)]
    strict_keys = bool(safety_cfg.strict_hydra_key_validation)
    forbid_plus_critical = bool(safety_cfg.prohibit_plus_on_critical)

    override_maps: Dict[str, Dict[str, str]] = {}
    errors: List[str] = []

    for job in jobs:
        per_job_keys: Dict[str, str] = {}
        for raw in job.overrides:
            try:
                spec = _parse_override(raw)
            except Exception as exc:
                errors.append(f'{job.run_id}: {exc}')
                continue

            if forbid_plus_critical and spec.has_plus and _is_critical_key(spec.key, critical_roots):
                errors.append(f"{job.run_id}: '+' override forbidden on critical key '{spec.key}'")

            if strict_keys and not _config_key_exists(validation_cfg, spec.key):
                errors.append(f"{job.run_id}: unknown Hydra key '{spec.key}' in override '{raw}'")

            per_job_keys[spec.key] = spec.value

        for req_key in required_fixed_dataset_keys:
            if req_key not in per_job_keys:
                errors.append(f"{job.run_id}: missing required fixed-dataset key '{req_key}'")

        fixed_keys_bool = {
            'use_fixed_dataset': True,
            'experiment.if_load_p_net': True,
            'experiment.if_load_v_nets': True,
        }
        for bool_key, expected in fixed_keys_bool.items():
            raw_val = per_job_keys.get(bool_key, '')
            parsed = _normalize_bool(raw_val)
            if parsed is None or parsed is not expected:
                errors.append(
                    f"{job.run_id}: expected {bool_key}={str(expected).lower()}, got '{raw_val}'"
                )

        p_path = per_job_keys.get('simulation.p_net_dataset_dir', '').strip()
        v_path = per_job_keys.get('simulation.v_nets_dataset_dir', '').strip()
        if not p_path:
            errors.append(f'{job.run_id}: simulation.p_net_dataset_dir must be non-empty')
        if not v_path:
            errors.append(f'{job.run_id}: simulation.v_nets_dataset_dir must be non-empty')
        if p_path and v_path and p_path != v_path:
            errors.append(
                f'{job.run_id}: fixed dataset mismatch '
                f"(p_net='{p_path}', v_nets='{v_path}')"
            )

        if job.is_offline_slice:
            offline_raw = per_job_keys.get('system.if_offline_system', '')
            offline_enabled = _normalize_bool(offline_raw)
            if offline_enabled is not True:
                errors.append(
                    f"{job.run_id}: offline slice requires system.if_offline_system=true, got '{offline_raw}'"
                )
            if not job.source_dataset_dir:
                errors.append(f'{job.run_id}: offline slice job missing source_dataset_dir')

        override_maps[job.run_id] = per_job_keys

    if errors:
        raise PreflightFailure('Override policy violations:\n' + '\n'.join(errors))
    return override_maps


def _validate_run_ids(
    jobs: Sequence[PlannedJob],
    override_maps: Mapping[str, Mapping[str, str]],
    safety_cfg: DictConfig,
) -> None:
    tokens_cfg = safety_cfg.run_id_tokens
    train_token = str(tokens_cfg.train)
    eval_token = str(tokens_cfg.eval)
    offline_token = str(tokens_cfg.get('offline', '__offline__'))

    errors: List[str] = []
    seen_solver_run_id: Dict[Tuple[str, str], str] = {}

    for job in jobs:
        override_map = override_maps[job.run_id]
        override_run_id = override_map.get('experiment.run_id')
        if override_run_id != job.run_id:
            errors.append(
                f'{job.run_id}: experiment.run_id override mismatch (got {override_run_id})'
            )

        has_train = train_token in job.run_id
        has_eval = eval_token in job.run_id
        has_offline = offline_token in job.run_id
        if has_train and has_eval:
            errors.append(f'{job.run_id}: run_id contains both stage tokens')
        if job.stage == 'train':
            if not has_train or has_eval:
                errors.append(f'{job.run_id}: train stage must include {train_token} only')
            if '__ktrain' not in job.run_id:
                errors.append(f'{job.run_id}: train run_id missing ktrain marker')
            if has_offline:
                errors.append(f'{job.run_id}: train run_id must not include offline token')
        if job.stage == 'eval':
            if not has_eval or has_train:
                errors.append(f'{job.run_id}: eval stage must include {eval_token} only')
            if '__keval' not in job.run_id:
                errors.append(f'{job.run_id}: eval run_id missing keval marker')
            if job.is_offline_slice and not has_offline:
                errors.append(
                    f'{job.run_id}: offline eval run_id must include {offline_token} token'
                )
            if not job.is_offline_slice and has_offline:
                errors.append(
                    f'{job.run_id}: non-offline eval run_id must not include {offline_token} token'
                )

        key = (job.solver_name, job.run_id)
        if key in seen_solver_run_id:
            errors.append(
                f'{job.run_id}: duplicate solver/run_id pair reused in stages '
                f"{seen_solver_run_id[key]} and {job.stage}"
            )
        else:
            seen_solver_run_id[key] = job.stage

    if errors:
        raise PreflightFailure('run_id safety violations:\n' + '\n'.join(errors))


def _validate_paired_matching_policy(
    jobs: Sequence[PlannedJob],
    suite_cfg: DictConfig,
    profile_cfg: DictConfig,
) -> Dict[str, Any]:
    pairing_cfg = suite_cfg.get('paired_matching_policy')
    if pairing_cfg is None:
        raise PreflightFailure('Missing journal_suite.paired_matching_policy')

    if not bool(pairing_cfg.get('enabled', True)):
        return {'enabled': False}

    pooled_method_keys = [str(v) for v in _as_list(pairing_cfg.get('method_keys', []))]
    if not pooled_method_keys:
        raise PreflightFailure(
            'paired_matching_policy.enabled=true requires non-empty method_keys'
        )

    match_fields = [str(v) for v in _as_list(pairing_cfg.get('match_fields', []))]
    if not match_fields:
        raise PreflightFailure(
            'paired_matching_policy.enabled=true requires non-empty match_fields'
        )

    allowed_fields = {'topology', 'scenario', 'seed', 'k_value'}
    unknown_fields = [field for field in match_fields if field not in allowed_fields]
    if unknown_fields:
        raise PreflightFailure(
            'paired_matching_policy.match_fields contains unsupported field(s): '
            + ', '.join(sorted(set(unknown_fields)))
        )
    required_fields = {'topology', 'seed'}
    if not required_fields.issubset(set(match_fields)):
        raise PreflightFailure(
            'paired_matching_policy.match_fields must include both topology and seed'
        )

    profile_method_keys = {str(v) for v in _as_list(profile_cfg.methods)}
    active_method_keys = [m for m in pooled_method_keys if m in profile_method_keys]
    if len(active_method_keys) < 2:
        return {
            'enabled': True,
            'status': 'skipped_insufficient_methods',
            'active_method_keys': active_method_keys,
            'configured_method_keys': pooled_method_keys,
            'match_fields': match_fields,
        }

    eval_jobs = [job for job in jobs if job.stage == 'eval' and job.method_key in active_method_keys]
    if not eval_jobs:
        raise PreflightFailure(
            'paired_matching_policy failed: no eval jobs found for active pooled methods'
        )

    def _field_value(job: PlannedJob, field: str) -> Any:
        if field == 'topology':
            return job.topology_key
        if field == 'scenario':
            return job.scenario_key
        if field == 'seed':
            return job.seed
        if field == 'k_value':
            return job.k_value
        raise ValueError(f'Unexpected matching field {field}')

    def _format_cell(cell: Tuple[Any, ...]) -> str:
        return ', '.join(f'{field}={value}' for field, value in zip(match_fields, cell))

    key_sets: Dict[str, set[Tuple[Any, ...]]] = {}
    for method_key in active_method_keys:
        method_jobs = [job for job in eval_jobs if job.method_key == method_key]
        if not method_jobs:
            raise PreflightFailure(
                f'paired_matching_policy failed: no eval jobs for method {method_key}'
            )
        key_sets[method_key] = {
            tuple(_field_value(job, field) for field in match_fields) for job in method_jobs
        }

    reference_method = active_method_keys[0]
    reference_keys = key_sets[reference_method]
    errors: List[str] = []
    for method_key in active_method_keys[1:]:
        candidate_keys = key_sets[method_key]
        if candidate_keys == reference_keys:
            continue

        missing_cells = sorted(reference_keys - candidate_keys)
        extra_cells = sorted(candidate_keys - reference_keys)
        if missing_cells:
            preview = '; '.join(_format_cell(cell) for cell in missing_cells[:10])
            errors.append(
                f'{method_key}: missing {len(missing_cells)} matched cell(s) vs '
                f'{reference_method}; sample: {preview}'
            )
        if extra_cells:
            preview = '; '.join(_format_cell(cell) for cell in extra_cells[:10])
            errors.append(
                f'{method_key}: has {len(extra_cells)} extra cell(s) vs '
                f'{reference_method}; sample: {preview}'
            )

    if errors:
        raise PreflightFailure('Paired seed/topology matching violations:\n' + '\n'.join(errors))

    return {
        'enabled': True,
        'status': 'enforced',
        'method_keys': active_method_keys,
        'match_fields': match_fields,
        'matched_cell_count': len(reference_keys),
        'cells_per_method': {method_key: len(key_sets[method_key]) for method_key in active_method_keys},
    }


def _pick_distinct_topologies(
    suite_cfg: DictConfig,
    repo_root: Path,
) -> Tuple[Path, Path]:
    topology_paths: List[Path] = []
    for entry in _as_dict(suite_cfg.topologies).values():
        entry_dict = _as_dict(entry)
        file_path = entry_dict.get('file_path')
        if not file_path:
            raise PreflightFailure('Each journal_suite.topologies.* entry must define file_path')
        topology_paths.append(_resolve_path(str(file_path), repo_root))
    existing = [p for p in topology_paths if p.exists()]
    if len(existing) < 2:
        raise PreflightFailure('Need at least two existing topology files for PN precedence check')

    counts: List[Tuple[Path, int]] = []
    for path in existing:
        graph = nx.read_gml(path, label='id')
        counts.append((path, graph.number_of_nodes()))

    for base_path, base_n in counts:
        for alt_path, alt_n in counts:
            if base_path == alt_path:
                continue
            if base_n != alt_n:
                return base_path, alt_path

    raise PreflightFailure(
        'Could not find two topology files with different node counts for PN precedence check'
    )


def _check_pn_load_precedence(validation_cfg: DictConfig, suite_cfg: DictConfig) -> Dict[str, Any]:
    dataset_topology, conflicting_topology = _pick_distinct_topologies(suite_cfg, REPO_ROOT)

    with tempfile.TemporaryDirectory(prefix='journal_pn_preflight_') as tmp_dir:
        tmp_path = Path(tmp_dir)
        shutil.copy2(dataset_topology, tmp_path / 'p_net.gml')

        cfg_load = copy.deepcopy(validation_cfg)
        with open_dict(cfg_load):
            cfg_load.use_fixed_dataset = True
            cfg_load.experiment.if_load_p_net = True
            cfg_load.experiment.if_load_v_nets = True
            cfg_load.experiment.seed = 7
            cfg_load.simulation.p_net_dataset_dir = str(tmp_path)
            cfg_load.simulation.v_nets_dataset_dir = str(tmp_path)
            cfg_load.p_net_setting.topology.file_path = str(conflicting_topology)

        loaded_p_net, _ = BaseSystem.load_dataset(_NullLogger(), cfg_load)
        loaded_nodes_when_true = int(loaded_p_net.num_nodes)

        cfg_regen = copy.deepcopy(cfg_load)
        with open_dict(cfg_regen):
            cfg_regen.experiment.if_load_p_net = False
        regenerated_p_net, _ = BaseSystem.load_dataset(_NullLogger(), cfg_regen)
        loaded_nodes_when_false = int(regenerated_p_net.num_nodes)

        dataset_nodes = int(PhysicalNetwork.load_dataset(str(tmp_path)).num_nodes)
        conflict_nodes = int(nx.read_gml(conflicting_topology, label='id').number_of_nodes())

    if loaded_nodes_when_true != dataset_nodes:
        raise PreflightFailure(
            'PN precedence check failed: if_load_p_net=true did not prefer dataset PN '
            f'(expected {dataset_nodes}, got {loaded_nodes_when_true})'
        )
    if loaded_nodes_when_false != conflict_nodes:
        raise PreflightFailure(
            'PN precedence check failed: if_load_p_net=false did not follow topology setting '
            f'(expected {conflict_nodes}, got {loaded_nodes_when_false})'
        )
    if dataset_nodes == conflict_nodes:
        raise PreflightFailure(
            'PN precedence check inconclusive: dataset and conflicting topologies have equal node counts'
        )

    return {
        'dataset_topology': str(dataset_topology),
        'conflicting_topology': str(conflicting_topology),
        'dataset_nodes': dataset_nodes,
        'conflicting_nodes': conflict_nodes,
        'loaded_nodes_if_load_true': loaded_nodes_when_true,
        'loaded_nodes_if_load_false': loaded_nodes_when_false,
    }


def _validate_offline_dataset_files(dataset_dir: Path) -> Tuple[bool, List[str]]:
    missing: List[str] = []
    if not (dataset_dir / 'p_net.gml').exists():
        missing.append('p_net.gml')
    if not (dataset_dir / 'events.yaml').exists():
        missing.append('events.yaml')
    if not (dataset_dir / 'v_sim_setting.yaml').exists():
        missing.append('v_sim_setting.yaml')
    v_nets_dir = dataset_dir / 'v_nets'
    if not v_nets_dir.exists() or not v_nets_dir.is_dir():
        missing.append('v_nets/')
    else:
        if not any(v_nets_dir.glob('*.gml')):
            missing.append('v_nets/*.gml')
    return len(missing) == 0, missing


def _probe_offline_dataset_load(
    dataset_dir: Path,
    validation_cfg: DictConfig,
    seed: int,
) -> Dict[str, Any]:
    cfg = copy.deepcopy(validation_cfg)
    with open_dict(cfg):
        cfg.use_fixed_dataset = True
        cfg.experiment.if_load_p_net = True
        cfg.experiment.if_load_v_nets = True
        cfg.system.if_offline_system = True
        cfg.experiment.seed = int(seed)
        cfg.simulation.p_net_dataset_dir = str(dataset_dir)
        cfg.simulation.v_nets_dataset_dir = str(dataset_dir)

    p_net, v_simulator = BaseSystem.load_dataset(_NullLogger(), cfg)
    loaded_v_simulator = v_simulator.load_dataset(str(dataset_dir))
    return {
        'dataset_dir': str(dataset_dir),
        'p_net_nodes': int(p_net.num_nodes),
        'num_v_nets': int(len(loaded_v_simulator.v_nets)),
        'num_events': int(len(loaded_v_simulator.events)),
    }


def _convert_dataset_for_offline(
    source_dataset_dir: Path,
    target_dataset_dir: Path,
    generation_cfg: DictConfig,
    force: bool,
) -> List[str]:
    actions: List[str] = []
    if target_dataset_dir.exists() and force:
        if target_dataset_dir.is_symlink() or target_dataset_dir.is_file():
            target_dataset_dir.unlink()
        elif target_dataset_dir.is_dir():
            shutil.rmtree(target_dataset_dir)
    if target_dataset_dir.exists():
        actions.append('reused_existing_target')
        return actions

    shutil.copytree(source_dataset_dir, target_dataset_dir)
    actions.append('copied_source_dataset')

    v_sim_setting_path = target_dataset_dir / 'v_sim_setting.yaml'
    if not v_sim_setting_path.exists():
        OmegaConf.save(generation_cfg.v_sim_setting, str(v_sim_setting_path))
        actions.append('wrote_v_sim_setting_yaml')
    return actions


def _materialize_offline_slice_dataset(
    source_dataset_dir: Path,
    target_dataset_dir: Path,
    generation_cfg: DictConfig,
    validation_cfg: DictConfig,
    seed: int,
    force: bool,
    conversion_enabled: bool,
) -> Dict[str, Any]:
    if not source_dataset_dir.exists():
        raise PreflightFailure(f'Offline slice source dataset missing: {source_dataset_dir}')

    source_ok, source_missing = _validate_offline_dataset_files(source_dataset_dir)
    source_probe: Optional[Dict[str, Any]] = None
    source_error: Optional[str] = None
    if source_ok:
        try:
            source_probe = _probe_offline_dataset_load(
                dataset_dir=source_dataset_dir,
                validation_cfg=validation_cfg,
                seed=seed,
            )
        except Exception as exc:
            source_error = str(exc)
            source_ok = False
    else:
        source_error = f'missing files: {", ".join(source_missing)}'

    if target_dataset_dir == source_dataset_dir:
        if not source_ok:
            raise PreflightFailure(
                f'Offline dataset path cannot equal source path when conversion is required: {source_error}'
            )
        return {
            'status': 'native_source',
            'source_dataset_dir': str(source_dataset_dir),
            'offline_dataset_dir': str(target_dataset_dir),
            'conversion_actions': [],
            'probe': source_probe,
        }

    if target_dataset_dir.exists() and force:
        if target_dataset_dir.is_symlink() or target_dataset_dir.is_file():
            target_dataset_dir.unlink()
        elif target_dataset_dir.is_dir():
            shutil.rmtree(target_dataset_dir)

    conversion_actions: List[str] = []
    status = 'linked_native'
    if source_ok:
        if not target_dataset_dir.exists():
            try:
                os.symlink(source_dataset_dir, target_dataset_dir, target_is_directory=True)
                conversion_actions.append('created_symlink_to_source')
            except Exception:
                shutil.copytree(source_dataset_dir, target_dataset_dir)
                conversion_actions.append('copied_source_dataset')
                status = 'copied_native'
    else:
        if not conversion_enabled:
            raise PreflightFailure(
                f'Offline slice dataset requires conversion but conversion is disabled: {source_error}'
            )
        conversion_actions.extend(
            _convert_dataset_for_offline(
                source_dataset_dir=source_dataset_dir,
                target_dataset_dir=target_dataset_dir,
                generation_cfg=generation_cfg,
                force=force,
            )
        )
        status = 'converted'

    target_ok, target_missing = _validate_offline_dataset_files(target_dataset_dir)
    if not target_ok:
        raise PreflightFailure(
            f'Offline slice dataset missing required files after materialization '
            f'({target_dataset_dir}): {", ".join(target_missing)}'
        )
    try:
        target_probe = _probe_offline_dataset_load(
            dataset_dir=target_dataset_dir,
            validation_cfg=validation_cfg,
            seed=seed,
        )
    except Exception as exc:
        raise PreflightFailure(
            f'Offline slice dataset cannot be loaded after materialization '
            f'({target_dataset_dir}): {exc}'
        ) from exc

    metadata = {
        'generated_at_utc': _now_iso(),
        'status': status,
        'source_dataset_dir': str(source_dataset_dir),
        'offline_dataset_dir': str(target_dataset_dir),
        'source_compatibility': bool(source_ok),
        'source_compatibility_error': source_error,
        'conversion_enabled': bool(conversion_enabled),
        'conversion_actions': conversion_actions,
        'probe': target_probe,
    }
    metadata_path = target_dataset_dir / 'offline_conversion_metadata.json'
    if target_dataset_dir.is_symlink():
        metadata_path = target_dataset_dir.parent / f'{target_dataset_dir.name}.offline_conversion_metadata.json'
    else:
        target_dataset_dir.mkdir(parents=True, exist_ok=True)
    with metadata_path.open('w', encoding='utf-8') as f:
        json.dump(metadata, f, indent=2, sort_keys=True)
    metadata['metadata_path'] = str(metadata_path)
    return metadata


def _check_offline_slice_compatibility(
    suite_cfg: DictConfig,
    profile_cfg: DictConfig,
    validation_cfg: DictConfig,
) -> Dict[str, Any]:
    plan = _resolve_offline_slice_plan(suite_cfg, profile_cfg)
    if not plan.enabled:
        return {'enabled': False}

    scenarios_cfg = suite_cfg.scenarios
    topologies_cfg = suite_cfg.topologies

    scenario_key = plan.scenario_keys[0]
    topology_key = plan.topology_keys[0]
    seed = int(plan.seeds[0])
    scenario_cfg = scenarios_cfg[scenario_key]
    eval_split = str(scenario_cfg.eval_split)
    topology_file = str(_resolve_path(str(topologies_cfg[topology_key].file_path), REPO_ROOT))

    with tempfile.TemporaryDirectory(prefix='journal_offline_preflight_') as tmp_dir:
        tmp_path = Path(tmp_dir)
        source_dir = tmp_path / 'source'
        dataset_spec = DatasetSpec(
            scenario_key=scenario_key,
            topology_key=topology_key,
            seed=seed,
            split=eval_split,
            dataset_dir=str(source_dir),
            topology_file_path=topology_file,
        )
        generation_cfg = _build_dataset_generation_config(
            validation_cfg=validation_cfg,
            dataset_spec=dataset_spec,
            scenario_cfg=scenario_cfg,
        )
        _materialize_dataset(
            dataset_spec=dataset_spec,
            generation_cfg=generation_cfg,
            force=False,
        )

        source_probe = _probe_offline_dataset_load(
            dataset_dir=source_dir,
            validation_cfg=validation_cfg,
            seed=seed,
        )
        offline_dir = _build_offline_dataset_dir(source_dir, plan.dataset_suffix)
        offline_metadata = _materialize_offline_slice_dataset(
            source_dataset_dir=source_dir,
            target_dataset_dir=offline_dir,
            generation_cfg=generation_cfg,
            validation_cfg=validation_cfg,
            seed=seed,
            force=True,
            conversion_enabled=plan.conversion_enabled,
        )

    return {
        'enabled': True,
        'method_keys': list(plan.method_keys),
        'topologies': list(plan.topology_keys),
        'scenarios': list(plan.scenario_keys),
        'seeds': list(plan.seeds),
        'k_eval_values': list(plan.k_eval_values),
        'conversion_enabled': bool(plan.conversion_enabled),
        'dataset_suffix': plan.dataset_suffix,
        'source_probe': source_probe,
        'offline_dataset_materialization': offline_metadata,
    }


def _build_k_semantics_fixture(validation_cfg: DictConfig) -> Tuple[PhysicalNetwork, VirtualNetwork]:
    graph = nx.Graph()
    graph.add_nodes_from([0, 1, 2, 3, 4])
    graph.add_edges_from([(0, 1), (1, 2), (0, 3), (3, 4), (4, 2)])
    p_net = PhysicalNetwork(incoming_graph_data=graph, config=validation_cfg.p_net_setting)
    for node_id in p_net.nodes:
        cpu_capacity = 10 if node_id in (0, 2) else 1
        p_net.nodes[node_id]['cpu'] = cpu_capacity
        p_net.nodes[node_id]['max_cpu'] = cpu_capacity
    for edge in p_net.edges:
        edge_key = tuple(sorted(edge))
        bw_capacity = 3 if edge_key in {(0, 1), (1, 2)} else 10
        p_net.edges[edge]['bw'] = bw_capacity
        p_net.edges[edge]['max_bw'] = bw_capacity

    v_graph = nx.Graph()
    v_graph.add_nodes_from([0, 1])
    v_graph.add_edge(0, 1)
    v_net = VirtualNetwork(incoming_graph_data=v_graph, config=validation_cfg.v_sim_setting)
    for node_id in v_net.nodes:
        v_net.nodes[node_id]['cpu'] = 5
    for edge in v_net.edges:
        v_net.edges[edge]['bw'] = 5
    v_net.id = 0
    v_net.lifetime = 100.0
    v_net.arrival_time = 0.0
    return p_net, v_net


def _run_solver_k_semantics_trial(
    solver_name: str,
    validation_cfg: DictConfig,
    p_net_template: PhysicalNetwork,
    v_net_template: VirtualNetwork,
    k_value: int,
    save_root_dir: Path,
    run_id: str,
) -> bool:
    from virne.core import Controller, Counter, Recorder

    cfg = copy.deepcopy(validation_cfg)
    with open_dict(cfg):
        cfg.solver.solver_name = solver_name
        cfg.solver.shortest_method = 'k_shortest'
        cfg.solver.k_shortest = int(k_value)
        cfg.experiment.seed = 0
        cfg.experiment.run_id = run_id
        cfg.experiment.save_root_dir = str(save_root_dir)
        cfg.experiment.if_save_config = False
        cfg.recorder.if_save_records = False
        cfg.recorder.if_temp_save_records = False
        cfg.logger.backends = []
        cfg.training.use_cuda = False
        cfg.training.distributed_training = False
        cfg.training.num_workers = 1
        cfg.training.inference_only = True
        cfg.training.enable_async_learner = False
        cfg.training.use_cpp_mcts = False
        if 'computation_budget' in cfg.training:
            cfg.training.computation_budget = max(5, int(cfg.training.computation_budget))

    node_attrs_setting = cfg.v_sim_setting['node_attrs_setting']
    link_attrs_setting = cfg.v_sim_setting['link_attrs_setting']
    graph_attrs_setting = cfg.v_sim_setting.get('graph_attrs_setting', {})
    counter = Counter(node_attrs_setting, link_attrs_setting, graph_attrs_setting, cfg)
    controller = Controller(node_attrs_setting, link_attrs_setting, graph_attrs_setting, cfg)
    recorder = Recorder(counter, cfg)
    solver_cls = SolverRegistry.get(solver_name)
    solver = solver_cls(controller, recorder, counter, _NullLogger(), cfg)

    # Bound expensive meta-heuristics during preflight capability checks.
    if hasattr(solver, 'num_particles'):
        solver.num_particles = min(int(getattr(solver, 'num_particles')), 2)
    if hasattr(solver, 'max_iteration'):
        solver.max_iteration = min(int(getattr(solver, 'max_iteration')), 2)

    try:
        solution = solver.solve(
            {
                'v_net': copy.deepcopy(v_net_template),
                'p_net': copy.deepcopy(p_net_template),
            }
        )
    finally:
        if hasattr(solver, 'close'):
            try:
                solver.close()
            except Exception:
                pass
    return bool(solution.get('result', False))


def _check_k_semantics_parity(
    suite_cfg: DictConfig,
    profile_cfg: DictConfig,
    validation_cfg: DictConfig,
) -> Dict[str, Any]:
    parity_cfg = suite_cfg.get('k_semantics_parity')
    if parity_cfg is None or not bool(parity_cfg.get('enabled', True)):
        return {'enabled': False}

    profile_method_keys = {str(v) for v in _as_list(profile_cfg.methods)}
    default_method_keys = [str(v) for v in _as_list(suite_cfg.paired_matching_policy.get('method_keys', []))]
    raw_method_keys = parity_cfg.get('method_keys')
    configured_method_keys = (
        [str(v) for v in _as_list(raw_method_keys)]
        if raw_method_keys is not None
        else default_method_keys
    )
    active_method_keys = [key for key in configured_method_keys if key in profile_method_keys]
    if not active_method_keys:
        return {
            'enabled': True,
            'status': 'skipped_no_active_methods',
            'configured_method_keys': configured_method_keys,
        }

    fail_k_value = int(parity_cfg.get('fail_k_value', 1))
    success_k_value = int(parity_cfg.get('success_k_value', 2))
    if success_k_value <= fail_k_value:
        raise PreflightFailure(
            'k_semantics_parity requires success_k_value > fail_k_value'
        )

    p_net_template, v_net_template = _build_k_semantics_fixture(validation_cfg)
    methods_cfg = suite_cfg.methods
    results: Dict[str, Dict[str, Any]] = {}
    errors: List[str] = []

    with tempfile.TemporaryDirectory(prefix='journal_k_semantics_preflight_') as tmp_dir:
        tmp_root = Path(tmp_dir)
        for method_key in active_method_keys:
            if method_key not in methods_cfg:
                raise PreflightFailure(f'k_semantics_parity references unknown method {method_key}')
            solver_name = str(methods_cfg[method_key].solver_name)
            fail_result = _run_solver_k_semantics_trial(
                solver_name=solver_name,
                validation_cfg=validation_cfg,
                p_net_template=p_net_template,
                v_net_template=v_net_template,
                k_value=fail_k_value,
                save_root_dir=tmp_root,
                run_id=f'k_semantics_{solver_name}_k{fail_k_value}',
            )
            success_result = _run_solver_k_semantics_trial(
                solver_name=solver_name,
                validation_cfg=validation_cfg,
                p_net_template=p_net_template,
                v_net_template=v_net_template,
                k_value=success_k_value,
                save_root_dir=tmp_root,
                run_id=f'k_semantics_{solver_name}_k{success_k_value}',
            )
            result_row = {
                'method_key': method_key,
                'solver_name': solver_name,
                'k_fail': fail_k_value,
                'k_fail_result': bool(fail_result),
                'k_success': success_k_value,
                'k_success_result': bool(success_result),
            }
            results[method_key] = result_row
            if fail_result:
                errors.append(
                    f'{method_key}/{solver_name}: expected failure at k={fail_k_value}, got success'
                )
            if not success_result:
                errors.append(
                    f'{method_key}/{solver_name}: expected success at k={success_k_value}, got failure'
                )

    if errors:
        raise PreflightFailure('k-semantics parity violations:\n' + '\n'.join(errors))

    return {
        'enabled': True,
        'status': 'enforced',
        'fail_k_value': fail_k_value,
        'success_k_value': success_k_value,
        'method_count': len(active_method_keys),
        'methods': active_method_keys,
        'results': results,
    }


def _render_job(job: PlannedJob) -> Dict[str, Any]:
    return {
        'stage': job.stage,
        'method_key': job.method_key,
        'solver_name': job.solver_name,
        'topology': job.topology_key,
        'scenario': job.scenario_key,
        'dataset_scenario': job.dataset_scenario_key,
        'train_source_scenario': job.train_source_scenario_key,
        'seed': job.seed,
        'k_value': job.k_value,
        'run_id': job.run_id,
        'dataset_dir': job.dataset_dir,
        'source_dataset_dir': job.source_dataset_dir,
        'is_offline_slice': bool(job.is_offline_slice),
        'overrides': list(job.overrides),
    }


def _write_manifest(
    manifest_path: Path,
    global_cfg: DictConfig,
    suite_cfg: DictConfig,
    profile_name: str,
    jobs: Sequence[PlannedJob],
    pn_precedence: Mapping[str, Any],
    matrix_contract: Mapping[str, Any],
    paired_matching_policy: Mapping[str, Any],
    offline_slice_compatibility: Mapping[str, Any],
    k_semantics_parity: Mapping[str, Any],
) -> None:
    manifest_path.parent.mkdir(parents=True, exist_ok=True)
    payload = {
        'generated_at_utc': _now_iso(),
        'git_commit': _git_commit(REPO_ROOT),
        'suite_name': str(suite_cfg.name),
        'profile': profile_name,
        'config_sha256': _config_hash(global_cfg),
        'thread_env': _as_dict(suite_cfg.thread_env),
        'job_count': len(jobs),
        'jobs': [_render_job(job) for job in jobs],
        'checks': {
            'strict_hydra_key_validation': bool(suite_cfg.safety.strict_hydra_key_validation),
            'prohibit_plus_on_critical': bool(suite_cfg.safety.prohibit_plus_on_critical),
            'stage_safe_run_id': True,
            'profile_matrix_contract': dict(matrix_contract),
            'fixed_dataset_pn_precedence': pn_precedence,
            'paired_seed_topology_matching': dict(paired_matching_policy),
            'offline_slice_compatibility': dict(offline_slice_compatibility),
            'k_semantics_parity': dict(k_semantics_parity),
        },
    }
    with manifest_path.open('w', encoding='utf-8') as f:
        json.dump(payload, f, indent=2, sort_keys=True)


def _write_dataset_manifest(
    manifest_path: Path,
    global_cfg: DictConfig,
    suite_cfg: DictConfig,
    profile_name: str,
    dataset_results: Sequence[Mapping[str, Any]],
    offline_slice_results: Sequence[Mapping[str, Any]],
    force: bool,
) -> None:
    manifest_path.parent.mkdir(parents=True, exist_ok=True)
    payload = {
        'generated_at_utc': _now_iso(),
        'git_commit': _git_commit(REPO_ROOT),
        'suite_name': str(suite_cfg.name),
        'profile': profile_name,
        'force': bool(force),
        'config_sha256': _config_hash(global_cfg),
        'dataset_count': len(dataset_results),
        'offline_slice_dataset_count': len(offline_slice_results),
        'generated_count': sum(
            1
            for result in dataset_results
            if result.get('status') in {'generated', 'regenerated'}
        ),
        'reused_count': sum(1 for result in dataset_results if result.get('status') == 'reused'),
        'datasets': list(dataset_results),
        'offline_slice_datasets': list(offline_slice_results),
    }
    with manifest_path.open('w', encoding='utf-8') as f:
        json.dump(payload, f, indent=2, sort_keys=True)


def _job_run_dir(save_root: Path, job: PlannedJob) -> Path:
    return save_root / job.solver_name / job.run_id


def _next_train_attempt_run_id(
    job: PlannedJob,
    save_root: Path,
) -> str:
    """Return a unique run_id for retraining attempts without clobbering prior outputs."""
    if job.stage != 'train':
        return job.run_id

    solver_dir = save_root / job.solver_name
    if not solver_dir.exists() or not solver_dir.is_dir():
        return job.run_id

    base_run_id = job.run_id
    pattern = re.compile(rf'^{re.escape(base_run_id)}__attempt(\d+)$')
    base_exists = False
    max_attempt = 0

    for child in solver_dir.iterdir():
        if not child.is_dir():
            continue
        if child.name == base_run_id:
            base_exists = True
            continue
        matched = pattern.match(child.name)
        if matched:
            max_attempt = max(max_attempt, int(matched.group(1)))

    if not base_exists and max_attempt == 0:
        return base_run_id
    return f'{base_run_id}__attempt{max_attempt + 1}'


def _retarget_job_run_id(
    job: PlannedJob,
    save_root: Path,
    new_run_id: str,
) -> PlannedJob:
    if new_run_id == job.run_id:
        return job

    updated_overrides: List[str] = []
    has_run_id_override = False
    has_hydra_dir_override = False
    for raw in job.overrides:
        spec = _parse_override(raw)
        prefix = '+' if spec.has_plus else ''
        if spec.key == 'experiment.run_id':
            updated_overrides.append(f'{prefix}experiment.run_id={new_run_id}')
            has_run_id_override = True
        elif spec.key == 'hydra.run.dir':
            hydra_dir = save_root / job.solver_name / new_run_id / 'hydra'
            updated_overrides.append(f'{prefix}hydra.run.dir={hydra_dir}')
            has_hydra_dir_override = True
        else:
            updated_overrides.append(raw)

    if not has_run_id_override:
        raise ValueError(f'Missing experiment.run_id override for {job.run_id}')
    if not has_hydra_dir_override:
        raise ValueError(f'Missing hydra.run.dir override for {job.run_id}')

    return replace(job, run_id=new_run_id, overrides=tuple(updated_overrides))


def _write_json_atomic(path: Path, payload: Mapping[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp_path = path.parent / f'{path.name}.tmp'
    with tmp_path.open('w', encoding='utf-8') as f:
        json.dump(payload, f, indent=2, sort_keys=True)
    os.replace(tmp_path, path)


def _resolve_train_registry_paths(suite_cfg: DictConfig) -> Tuple[Path, Path]:
    suite_root = _resolve_path(str(suite_cfg.paths.suite_root), REPO_ROOT)
    default_registry_path = suite_root / 'model_registry.csv'
    default_shards_dir = suite_root / 'model_registry_shards'
    registry_path_raw = suite_cfg.paths.get('model_registry_path', str(default_registry_path))
    shards_dir_raw = suite_cfg.paths.get('model_registry_shards_dir', str(default_shards_dir))
    registry_path = _resolve_path(str(registry_path_raw), REPO_ROOT)
    shards_dir = _resolve_path(str(shards_dir_raw), REPO_ROOT)
    return registry_path, shards_dir


def _is_nonempty_file(path: Path) -> bool:
    try:
        return path.exists() and path.is_file() and path.stat().st_size > 0
    except OSError:
        return False


def _discover_trained_model_path(run_dir: Path, solver_name: str) -> Optional[Path]:
    model_dir = run_dir / 'models'
    replay_dir = run_dir / 'replay_buffer'
    static_candidates = [
        model_dir / 'policy_latest.pt',
        model_dir / 'policy_latest_full.pt',
        replay_dir / 'policy_latest.pt',
        replay_dir / 'policy_latest_full.pt',
        run_dir / 'policy_latest.pt',
        model_dir / 'model.pkl',
        model_dir / 'model.pt',
        model_dir / 'model.pth',
    ]
    if solver_name == 'alpha_zero_sfc':
        static_candidates = [
            model_dir / 'policy_latest.pt',
            model_dir / 'policy_latest_full.pt',
            *static_candidates,
        ]
    for candidate in static_candidates:
        if _is_nonempty_file(candidate):
            return candidate.resolve()

    search_dirs = [model_dir, replay_dir, run_dir]
    for candidate_dir in search_dirs:
        if not candidate_dir.exists() or not candidate_dir.is_dir():
            continue
        dynamic_candidates: List[Path] = []
        for pattern in ('policy_latest*.pt', 'model*.pkl', 'model*.pt', '*.pt', '*.pth', '*.pkl'):
            dynamic_candidates.extend(candidate_dir.glob(pattern))
        dynamic_candidates = [p for p in dynamic_candidates if _is_nonempty_file(p)]
        if dynamic_candidates:
            latest = max(dynamic_candidates, key=lambda p: p.stat().st_mtime)
            return latest.resolve()
    return None


def _wait_for_trained_model_path(
    run_dir: Path,
    solver_name: str,
    timeout_sec: float = 8.0,
    poll_sec: float = 0.2,
) -> Optional[Path]:
    """Wait briefly for checkpoint files that may appear right after process exit."""
    timeout = max(0.0, float(timeout_sec))
    poll = max(0.05, float(poll_sec))
    deadline = time.time() + timeout
    while True:
        model_path = _discover_trained_model_path(run_dir, solver_name)
        if model_path is not None:
            return model_path
        if time.time() >= deadline:
            return None
        time.sleep(poll)


def _train_completion_marker_path(run_dir: Path) -> Path:
    return run_dir / 'train_completed.json'


def _is_train_job_completed(
    job: PlannedJob,
    save_root: Path,
) -> Tuple[bool, Optional[Path]]:
    run_dir = _job_run_dir(save_root, job)
    marker_path = _train_completion_marker_path(run_dir)
    if marker_path.exists():
        try:
            marker = json.loads(marker_path.read_text(encoding='utf-8'))
            model_path_text = str(marker.get('model_path', '')).strip()
            if model_path_text:
                model_path = Path(model_path_text)
                if _is_nonempty_file(model_path):
                    return True, model_path.resolve()
        except Exception:
            pass

    model_path = _discover_trained_model_path(run_dir, job.solver_name)
    summary_exists = (run_dir / 'summary.csv').exists()
    if model_path is not None and summary_exists:
        return True, model_path
    return False, model_path


def _write_train_completion_marker(
    job: PlannedJob,
    run_dir: Path,
    model_path: Path,
) -> None:
    payload = {
        'completed_at_utc': _now_iso(),
        'stage': job.stage,
        'method_key': job.method_key,
        'solver_name': job.solver_name,
        'topology': job.topology_key,
        'scenario': job.scenario_key,
        'seed': int(job.seed),
        'k_train': int(job.k_value),
        'run_id': job.run_id,
        'model_path': str(model_path.resolve()),
    }
    _write_json_atomic(_train_completion_marker_path(run_dir), payload)


def _normalize_registry_row(row: Mapping[str, Any]) -> Dict[str, str]:
    normalized: Dict[str, str] = {}
    for column in MODEL_REGISTRY_COLUMNS:
        normalized[column] = str(row.get(column, ''))
    return normalized


def _build_registry_row(
    job: PlannedJob,
    model_path: Path,
) -> Dict[str, str]:
    return _normalize_registry_row(
        {
            'method': job.method_key,
            'solver_name': job.solver_name,
            'topology': job.topology_key,
            'scenario': job.scenario_key,
            'seed': str(job.seed),
            'k_train': str(job.k_value),
            'model_path': str(model_path.resolve()),
            'run_id': job.run_id,
            'updated_at_utc': _now_iso(),
        }
    )


def _write_registry_shard(
    shards_dir: Path,
    registry_row: Mapping[str, str],
) -> Path:
    shards_dir.mkdir(parents=True, exist_ok=True)
    run_id = str(registry_row.get('run_id', '')).strip()
    if not run_id:
        raise ValueError('registry shard row is missing run_id')
    shard_path = shards_dir / f'{run_id}.json'
    _write_json_atomic(shard_path, registry_row)
    return shard_path


def _merge_model_registry(
    registry_path: Path,
    shards_dir: Path,
) -> int:
    registry_path.parent.mkdir(parents=True, exist_ok=True)
    lock_path = registry_path.parent / f'{registry_path.name}.lock'
    lock_path.parent.mkdir(parents=True, exist_ok=True)

    with lock_path.open('a+', encoding='utf-8') as lock_file:
        if fcntl is not None:
            fcntl.flock(lock_file.fileno(), fcntl.LOCK_EX)
        try:
            rows_by_run_id: Dict[str, Dict[str, str]] = {}
            if registry_path.exists():
                with registry_path.open('r', newline='', encoding='utf-8') as f:
                    reader = csv.DictReader(f)
                    for row in reader:
                        run_id = str(row.get('run_id', '')).strip()
                        if not run_id:
                            continue
                        rows_by_run_id[run_id] = _normalize_registry_row(row)

            if shards_dir.exists():
                for shard_path in sorted(shards_dir.glob('*.json')):
                    try:
                        row = json.loads(shard_path.read_text(encoding='utf-8'))
                    except Exception:
                        continue
                    run_id = str(row.get('run_id', '')).strip()
                    if not run_id:
                        continue
                    rows_by_run_id[run_id] = _normalize_registry_row(row)

            rows = sorted(
                rows_by_run_id.values(),
                key=lambda row: (
                    row.get('method', ''),
                    row.get('topology', ''),
                    row.get('scenario', ''),
                    row.get('seed', ''),
                    row.get('k_train', ''),
                    row.get('run_id', ''),
                ),
            )

            tmp_path = registry_path.parent / f'{registry_path.name}.tmp'
            with tmp_path.open('w', newline='', encoding='utf-8') as f:
                writer = csv.DictWriter(f, fieldnames=list(MODEL_REGISTRY_COLUMNS))
                writer.writeheader()
                writer.writerows(rows)
            os.replace(tmp_path, registry_path)
            return len(rows)
        finally:
            if fcntl is not None:
                fcntl.flock(lock_file.fileno(), fcntl.LOCK_UN)


def _read_model_registry_rows(registry_path: Path) -> List[Dict[str, str]]:
    if not registry_path.exists():
        return []
    rows: List[Dict[str, str]] = []
    with registry_path.open('r', newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            rows.append(_normalize_registry_row(row))
    return rows


def _safe_int(value: Any) -> Optional[int]:
    text = str(value).strip()
    if not text:
        return None
    try:
        return int(text)
    except Exception:
        return None


def _override_value(overrides: Sequence[str], key: str) -> Optional[str]:
    for raw in overrides:
        spec = _parse_override(raw)
        if spec.key == key:
            return spec.value
    return None


def _upsert_override(overrides: Sequence[str], key: str, value: str) -> Tuple[str, ...]:
    updated: List[str] = []
    replaced = False
    for raw in overrides:
        spec = _parse_override(raw)
        if spec.key == key:
            prefix = '+' if spec.has_plus else ''
            updated.append(f'{prefix}{key}={value}')
            replaced = True
        else:
            updated.append(raw)
    if not replaced:
        updated.append(f'{key}={value}')
    return tuple(updated)


def _run_id_with_checkpoint_token(run_id: str, checkpoint_token: str) -> str:
    token = _sanitize_token(checkpoint_token) or 'na'
    if '__ckpt' in run_id:
        head, _sep, _tail = run_id.rpartition('__ckpt')
        return f'{head}__ckpt{token}'
    return f'{run_id}__ckpt{token}'


def _checkpoint_token_for_model(model_path: Optional[Path]) -> str:
    if model_path is None:
        return 'base'
    try:
        stat = model_path.stat()
        payload = (
            f'{model_path.resolve()}:{stat.st_size}:{stat.st_mtime_ns}'
        ).encode('utf-8')
    except Exception:
        payload = str(model_path).encode('utf-8')
    return hashlib.sha256(payload).hexdigest()[:10]


def _resolve_eval_model_path(
    job: PlannedJob,
    method_cfg: DictConfig,
    registry_rows: Sequence[Mapping[str, str]],
) -> Optional[Path]:
    if not bool(method_cfg.get('trainable', False)):
        return None

    train_scenario = job.train_source_scenario_key or job.scenario_key
    candidates: List[Tuple[Mapping[str, str], Path]] = []
    for row in registry_rows:
        if str(row.get('method', '')).strip() != job.method_key:
            continue
        if str(row.get('topology', '')).strip() != job.topology_key:
            continue
        if str(row.get('scenario', '')).strip() != train_scenario:
            continue
        if _safe_int(row.get('seed')) != int(job.seed):
            continue
        model_path_text = str(row.get('model_path', '')).strip()
        if not model_path_text:
            continue
        model_path = Path(model_path_text)
        if not _is_nonempty_file(model_path):
            continue
        candidates.append((row, model_path.resolve()))

    if not candidates:
        raise PreflightFailure(
            f'[eval] missing model registry entry for method={job.method_key} '
            f'topology={job.topology_key} scenario={train_scenario} seed={job.seed}'
        )

    train_k_values = [int(v) for v in _as_list(method_cfg.get('train_k_values', []))]
    preferred_k: Optional[int] = None
    if train_k_values:
        if int(job.k_value) in train_k_values:
            preferred_k = int(job.k_value)
        elif len(train_k_values) == 1:
            preferred_k = int(train_k_values[0])

    if preferred_k is not None:
        k_candidates = [
            item for item in candidates if _safe_int(item[0].get('k_train')) == preferred_k
        ]
        if not k_candidates:
            raise PreflightFailure(
                f'[eval] no checkpoint with k_train={preferred_k} for '
                f'method={job.method_key} topology={job.topology_key} '
                f'scenario={train_scenario} seed={job.seed}'
            )
        candidates = k_candidates

    candidates.sort(
        key=lambda item: (
            str(item[0].get('updated_at_utc', '')),
            str(item[0].get('run_id', '')),
        )
    )
    return candidates[-1][1]


def _resolve_eval_job(
    job: PlannedJob,
    suite_cfg: DictConfig,
    method_cfg: DictConfig,
    save_root: Path,
    registry_rows: Sequence[Mapping[str, str]],
) -> Tuple[PlannedJob, Optional[Path]]:
    eval_cfg = suite_cfg.get('evaluation', OmegaConf.create({}))
    request_timeout_sec = max(0.0, float(eval_cfg.get('request_timeout_sec', 0.0)))
    run_watchdog_timeout_sec = max(0.0, float(eval_cfg.get('run_watchdog_timeout_sec', 0.0)))
    record_arrival_solve_time = bool(eval_cfg.get('record_arrival_solve_time', True))
    gpu_synchronize_timing = bool(eval_cfg.get('gpu_synchronize_timing', True))

    model_path = _resolve_eval_model_path(
        job=job,
        method_cfg=method_cfg,
        registry_rows=registry_rows,
    )
    checkpoint_token = _checkpoint_token_for_model(model_path)
    run_id = _run_id_with_checkpoint_token(job.run_id, checkpoint_token)
    resolved_job = _retarget_job_run_id(job=job, save_root=save_root, new_run_id=run_id)

    overrides = resolved_job.overrides
    overrides = _upsert_override(
        overrides,
        'experiment.request_timeout_sec',
        f'{request_timeout_sec}',
    )
    overrides = _upsert_override(
        overrides,
        'experiment.run_watchdog_timeout_sec',
        f'{run_watchdog_timeout_sec}',
    )
    overrides = _upsert_override(
        overrides,
        'experiment.record_arrival_solve_time',
        'true' if record_arrival_solve_time else 'false',
    )
    overrides = _upsert_override(
        overrides,
        'experiment.gpu_synchronize_timing',
        'true' if gpu_synchronize_timing else 'false',
    )
    overrides = _upsert_override(overrides, 'training.inference_only', 'true')
    overrides = _upsert_override(overrides, 'training.num_train_epochs', '0')
    overrides = _upsert_override(overrides, 'training.enable_async_learner', 'false')
    overrides = _upsert_override(overrides, 'training.distributed_training', 'false')
    overrides = _upsert_override(overrides, 'training.num_workers', '1')
    if model_path is not None:
        overrides = _upsert_override(
            overrides,
            'solver.pretrained_model_path',
            str(model_path),
        )
        if resolved_job.solver_name == 'alpha_zero_sfc':
            overrides = _upsert_override(
                overrides,
                'training.alphazero_model_path',
                str(model_path),
            )
            overrides = _upsert_override(overrides, 'training.resume_training', 'false')

    return replace(resolved_job, overrides=tuple(overrides)), model_path


def _next_eval_attempt_run_id(
    job: PlannedJob,
    save_root: Path,
) -> str:
    if job.stage != 'eval':
        return job.run_id

    solver_dir = save_root / job.solver_name
    if not solver_dir.exists() or not solver_dir.is_dir():
        return job.run_id

    base_run_id = job.run_id
    pattern = re.compile(rf'^{re.escape(base_run_id)}__attempt(\d+)$')
    base_exists = False
    max_attempt = 0

    for child in solver_dir.iterdir():
        if not child.is_dir():
            continue
        if child.name == base_run_id:
            base_exists = True
            continue
        matched = pattern.match(child.name)
        if matched:
            max_attempt = max(max_attempt, int(matched.group(1)))

    if not base_exists and max_attempt == 0:
        return base_run_id
    return f'{base_run_id}__attempt{max_attempt + 1}'


def _eval_completion_marker_path(run_dir: Path) -> Path:
    return run_dir / 'eval_completed.json'


def _is_eval_job_completed(job: PlannedJob, save_root: Path) -> bool:
    run_dir = _job_run_dir(save_root, job)
    marker_path = _eval_completion_marker_path(run_dir)
    if marker_path.exists():
        return True

    metadata_path = run_dir / 'eval_run_metadata.json'
    if metadata_path.exists():
        try:
            metadata = json.loads(metadata_path.read_text(encoding='utf-8'))
            if bool(metadata.get('run_timeout', False)):
                return True
            returncode_raw = metadata.get('returncode')
            if returncode_raw is None:
                return False
            return int(returncode_raw) == 0
        except Exception:
            return False

    return False


def _write_eval_completion_marker(
    job: PlannedJob,
    run_dir: Path,
    model_path: Optional[Path],
    run_timeout: bool,
    watchdog_timeout_sec: float,
) -> None:
    payload = {
        'completed_at_utc': _now_iso(),
        'stage': job.stage,
        'method_key': job.method_key,
        'solver_name': job.solver_name,
        'topology': job.topology_key,
        'scenario': job.scenario_key,
        'seed': int(job.seed),
        'k_eval': int(job.k_value),
        'run_id': job.run_id,
        'model_path': str(model_path) if model_path is not None else '',
        'run_timeout': bool(run_timeout),
        'run_watchdog_timeout_sec': float(max(0.0, watchdog_timeout_sec)),
    }
    _write_json_atomic(_eval_completion_marker_path(run_dir), payload)


def _read_csv_dict_rows(path: Path) -> Tuple[List[str], List[Dict[str, str]]]:
    if not path.exists():
        return [], []
    with path.open('r', newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        fieldnames = list(reader.fieldnames or [])
        rows = [dict(row) for row in reader]
    return fieldnames, rows


def _write_csv_dict_rows(path: Path, fieldnames: Sequence[str], rows: Sequence[Mapping[str, Any]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp_path = path.parent / f'{path.name}.tmp'
    with tmp_path.open('w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=list(fieldnames))
        writer.writeheader()
        for row in rows:
            writer.writerow({key: row.get(key, '') for key in fieldnames})
    os.replace(tmp_path, path)


def _ensure_run_timeout_in_summary(
    job: PlannedJob,
    run_dir: Path,
    run_timeout: bool,
    watchdog_timeout_sec: float,
    elapsed_sec: float,
) -> None:
    summary_path = run_dir / 'summary.csv'
    fieldnames, rows = _read_csv_dict_rows(summary_path)
    if not rows:
        rows = [
            {
                'solver_name': job.solver_name,
                'seed': str(job.seed),
                'p_net_dataset_dir': str(job.dataset_dir),
                'v_nets_dataset_dir': str(job.dataset_dir),
                'run_id': job.run_id,
                'start_run_time': datetime.now().strftime('%Y%m%dT%H%M%S'),
                'clock_running_time': f'{max(0.0, elapsed_sec):.6f}',
                'acceptance_rate': '0.0',
                'long_term_r2c_ratio': '0.0',
                'success_count': '0',
                'total_cost': '0.0',
                'total_revenue': '0.0',
                'total_time_revenue': '0.0',
                'total_time_cost': '0.0',
                'total_simulation_time': '0.0',
                'num_arrival_requests': '0',
                'request_timeout_count': '0',
                'timed_out_arrivals': '0',
            }
        ]
        if not fieldnames:
            fieldnames = list(rows[0].keys())

    target_index = len(rows) - 1
    for idx in range(len(rows) - 1, -1, -1):
        if str(rows[idx].get('run_id', '')).strip() == job.run_id:
            target_index = idx
            break
    row = rows[target_index]
    row['run_timeout'] = '1' if run_timeout else '0'
    row['run_watchdog_timeout_sec'] = f'{max(0.0, watchdog_timeout_sec):.6f}'
    if not row.get('clock_running_time'):
        row['clock_running_time'] = f'{max(0.0, elapsed_sec):.6f}'
    if not row.get('num_arrival_requests'):
        row['num_arrival_requests'] = str(row.get('v_net_count', '0') or '0')
    if not row.get('request_timeout_count'):
        row['request_timeout_count'] = '0'
    if not row.get('timed_out_arrivals'):
        row['timed_out_arrivals'] = row['request_timeout_count']
    rows[target_index] = row

    required_fields = [
        'run_timeout',
        'run_watchdog_timeout_sec',
        'num_arrival_requests',
        'request_timeout_count',
        'timed_out_arrivals',
    ]
    for key in required_fields:
        if key not in fieldnames:
            fieldnames.append(key)
    _write_csv_dict_rows(summary_path, fieldnames, rows)


def _run_eval_job_subprocess(
    job: PlannedJob,
    run_dir: Path,
    env: Mapping[str, str],
    watchdog_timeout_sec: float,
) -> Dict[str, Any]:
    run_dir.mkdir(parents=True, exist_ok=True)
    cmd = [sys.executable, str(REPO_ROOT / 'main.py'), *job.overrides]
    command_path = run_dir / 'eval_command.txt'
    command_path.write_text(shlex.join(cmd) + '\n', encoding='utf-8')

    stdout_path = run_dir / 'stdout.log'
    stderr_path = run_dir / 'stderr.log'
    started_at = time.perf_counter()
    run_timeout = False
    run_failed = False
    returncode: Optional[int] = None
    failure_reason = ''

    with stdout_path.open('w', encoding='utf-8') as stdout_file, stderr_path.open(
        'w', encoding='utf-8'
    ) as stderr_file:
        try:
            result = subprocess.run(
                cmd,
                cwd=str(REPO_ROOT),
                env=dict(env),
                stdout=stdout_file,
                stderr=stderr_file,
                check=False,
                text=True,
                timeout=watchdog_timeout_sec if watchdog_timeout_sec > 0.0 else None,
            )
            returncode = int(result.returncode)
        except subprocess.TimeoutExpired:
            run_timeout = True
            failure_reason = 'run_watchdog_timeout'
        except Exception as exc:
            run_failed = True
            failure_reason = f'subprocess_error: {exc}'

    elapsed_sec = max(0.0, time.perf_counter() - started_at)
    if not run_timeout and not run_failed and returncode not in (None, 0):
        run_failed = True
        failure_reason = f'nonzero_exit_code:{returncode}'
    _ensure_run_timeout_in_summary(
        job=job,
        run_dir=run_dir,
        run_timeout=run_timeout,
        watchdog_timeout_sec=watchdog_timeout_sec,
        elapsed_sec=elapsed_sec,
    )

    metadata = {
        'completed_at_utc': _now_iso(),
        'run_timeout': bool(run_timeout),
        'run_failed': bool(run_failed),
        'failure_reason': failure_reason,
        'run_watchdog_timeout_sec': float(max(0.0, watchdog_timeout_sec)),
        'returncode': returncode,
        'elapsed_sec': float(elapsed_sec),
        'stdout_log': str(stdout_path),
        'stderr_log': str(stderr_path),
        'command': shlex.join(cmd),
    }
    _write_json_atomic(run_dir / 'eval_run_metadata.json', metadata)
    return metadata


def _run_eval_job_worker(
    job: PlannedJob,
    run_dir: Path,
    env: Mapping[str, str],
    watchdog_timeout_sec: float,
    model_path: Optional[Path],
) -> Dict[str, Any]:
    metadata = _run_eval_job_subprocess(
        job=job,
        run_dir=run_dir,
        env=env,
        watchdog_timeout_sec=watchdog_timeout_sec,
    )
    run_timeout = bool(metadata.get('run_timeout', False))
    run_failed = bool(metadata.get('run_failed', False))
    returncode_raw = metadata.get('returncode')
    returncode: Optional[int]
    try:
        returncode = None if returncode_raw is None else int(returncode_raw)
    except Exception:
        returncode = None

    if not run_failed:
        _write_eval_completion_marker(
            job=job,
            run_dir=run_dir,
            model_path=model_path,
            run_timeout=run_timeout,
            watchdog_timeout_sec=watchdog_timeout_sec,
        )

    return {
        'run_timeout': run_timeout,
        'run_failed': run_failed,
        'returncode': returncode,
        'failure_reason': str(metadata.get('failure_reason', '')),
    }


def _run_train_job_subprocess(
    job: PlannedJob,
    run_dir: Path,
    env: Mapping[str, str],
) -> None:
    run_dir.mkdir(parents=True, exist_ok=True)
    cmd = [sys.executable, str(REPO_ROOT / 'main.py'), *job.overrides]
    command_path = run_dir / 'train_command.txt'
    command_path.write_text(shlex.join(cmd) + '\n', encoding='utf-8')

    stdout_path = run_dir / 'stdout.log'
    stderr_path = run_dir / 'stderr.log'
    with stdout_path.open('w', encoding='utf-8') as stdout_file, stderr_path.open(
        'w', encoding='utf-8'
    ) as stderr_file:
        result = subprocess.run(
            cmd,
            cwd=str(REPO_ROOT),
            env=dict(env),
            stdout=stdout_file,
            stderr=stderr_file,
            check=False,
            text=True,
        )
    if result.returncode != 0:
        raise RuntimeError(
            f'train job failed ({job.run_id}) with exit code {result.returncode}; '
            f'see {stdout_path} and {stderr_path}'
        )


def run_train(
    config_path: Path,
    profile_name: Optional[str],
    resume: bool = False,
) -> int:
    global_cfg, suite_cfg = _load_suite_config(config_path)
    _validate_profile_matrix_contracts(suite_cfg)
    selected_profile, profile_cfg = _profile_or_default(suite_cfg, profile_name)
    jobs = _build_planned_jobs(suite_cfg=suite_cfg, profile_cfg=profile_cfg, repo_root=REPO_ROOT)
    train_jobs = [job for job in jobs if job.stage == 'train']

    if not train_jobs:
        print(f'[train] profile={selected_profile} has no train jobs')
        return 0

    validation_cfg = _compose_validation_base(global_cfg, REPO_ROOT / 'settings')
    override_maps = _validate_override_policy(
        jobs=train_jobs,
        validation_cfg=validation_cfg,
        safety_cfg=suite_cfg.safety,
    )
    _validate_run_ids(jobs=train_jobs, override_maps=override_maps, safety_cfg=suite_cfg.safety)

    save_root = _resolve_path(str(suite_cfg.paths.save_root_dir), REPO_ROOT)
    registry_path, shard_dir = _resolve_train_registry_paths(suite_cfg)
    env = os.environ.copy()
    for key, value in _as_dict(suite_cfg.thread_env).items():
        env[str(key)] = str(value)
    env['PYTHONUNBUFFERED'] = '1'

    total_jobs = len(train_jobs)
    executed = 0
    skipped = 0
    for idx, job in enumerate(train_jobs, start=1):
        dataset_dir = Path(job.dataset_dir)
        if not dataset_dir.exists():
            raise PreflightFailure(
                f'[train] missing dataset for {job.run_id}: {dataset_dir}. '
                'Run --stage generate-datasets first.'
            )

        is_completed, existing_model_path = _is_train_job_completed(job=job, save_root=save_root)
        if resume and is_completed and existing_model_path is not None:
            registry_row = _build_registry_row(job=job, model_path=existing_model_path)
            _write_registry_shard(shards_dir=shard_dir, registry_row=registry_row)
            merged_rows = _merge_model_registry(registry_path=registry_path, shards_dir=shard_dir)
            skipped += 1
            print(
                f'[train] skip ({idx}/{total_jobs}) run_id={job.run_id} '
                f'model={existing_model_path} registry_rows={merged_rows}'
            )
            continue

        train_job = job
        if not resume:
            effective_run_id = _next_train_attempt_run_id(job=job, save_root=save_root)
            if effective_run_id != job.run_id:
                train_job = _retarget_job_run_id(
                    job=job,
                    save_root=save_root,
                    new_run_id=effective_run_id,
                )
                print(
                    f'[train] rerun detected for {job.run_id}; '
                    f'using unique attempt run_id={train_job.run_id}'
                )
        else:
            run_dir_existing = _job_run_dir(save_root, job)
            if run_dir_existing.exists() and not is_completed:
                effective_run_id = _next_train_attempt_run_id(job=job, save_root=save_root)
                if effective_run_id != job.run_id:
                    train_job = _retarget_job_run_id(
                        job=job,
                        save_root=save_root,
                        new_run_id=effective_run_id,
                    )
                    print(
                        f'[train] incomplete prior output for {job.run_id}; '
                        f'using unique attempt run_id={train_job.run_id}'
                    )

        run_dir = _job_run_dir(save_root, train_job)
        print(f'[train] run ({idx}/{total_jobs}) run_id={train_job.run_id}')
        _run_train_job_subprocess(job=train_job, run_dir=run_dir, env=env)
        model_path = _wait_for_trained_model_path(
            run_dir=run_dir,
            solver_name=train_job.solver_name,
        )
        if model_path is None:
            raise PreflightFailure(
                f'[train] completed process but no checkpoint was found for {train_job.run_id} '
                f'under {run_dir / "models"}'
            )

        _write_train_completion_marker(job=train_job, run_dir=run_dir, model_path=model_path)
        registry_row = _build_registry_row(job=train_job, model_path=model_path)
        _write_registry_shard(shards_dir=shard_dir, registry_row=registry_row)
        merged_rows = _merge_model_registry(registry_path=registry_path, shards_dir=shard_dir)
        executed += 1
        print(
            f'[train] done ({idx}/{total_jobs}) run_id={train_job.run_id} '
            f'model={model_path} registry_rows={merged_rows}'
        )

    merged_rows = _merge_model_registry(registry_path=registry_path, shards_dir=shard_dir)
    print('[train] success')
    print(
        f'[train] profile={selected_profile} jobs={total_jobs} '
        f'executed={executed} skipped={skipped} registry_rows={merged_rows}'
    )
    print(f'[train] model_registry={registry_path}')
    return 0


def run_eval(
    config_path: Path,
    profile_name: Optional[str],
    resume: bool = False,
) -> int:
    global_cfg, suite_cfg = _load_suite_config(config_path)
    _validate_profile_matrix_contracts(suite_cfg)
    selected_profile, profile_cfg = _profile_or_default(suite_cfg, profile_name)
    jobs = _build_planned_jobs(suite_cfg=suite_cfg, profile_cfg=profile_cfg, repo_root=REPO_ROOT)
    eval_jobs = [job for job in jobs if job.stage == 'eval']

    if not eval_jobs:
        print(f'[eval] profile={selected_profile} has no eval jobs')
        return 0

    validation_cfg = _compose_validation_base(global_cfg, REPO_ROOT / 'settings')
    override_maps = _validate_override_policy(
        jobs=eval_jobs,
        validation_cfg=validation_cfg,
        safety_cfg=suite_cfg.safety,
    )
    _validate_run_ids(jobs=eval_jobs, override_maps=override_maps, safety_cfg=suite_cfg.safety)

    methods_cfg = suite_cfg.methods
    save_root = _resolve_path(str(suite_cfg.paths.save_root_dir), REPO_ROOT)
    registry_path, shard_dir = _resolve_train_registry_paths(suite_cfg)
    eval_cfg = suite_cfg.get('evaluation', OmegaConf.create({}))
    watchdog_timeout_sec = max(0.0, float(eval_cfg.get('run_watchdog_timeout_sec', 0.0)))
    parallelism = int(eval_cfg.get('parallelism', 1))
    if parallelism < 1:
        parallelism = 1

    needs_registry = any(bool(methods_cfg[job.method_key].get('trainable', False)) for job in eval_jobs)
    if needs_registry:
        _merge_model_registry(registry_path=registry_path, shards_dir=shard_dir)
    registry_rows = _read_model_registry_rows(registry_path=registry_path)
    if needs_registry and not registry_rows:
        raise PreflightFailure(
            f'[eval] model registry is empty at {registry_path}; run --stage train first.'
        )

    resolved_jobs: List[PlannedJob] = []
    model_path_by_run_id: Dict[str, Optional[Path]] = {}
    run_id_occurrences: Dict[str, int] = {}
    for job in eval_jobs:
        method_cfg = methods_cfg[job.method_key]
        resolved_job, model_path = _resolve_eval_job(
            job=job,
            suite_cfg=suite_cfg,
            method_cfg=method_cfg,
            save_root=save_root,
            registry_rows=registry_rows,
        )
        base_run_id = resolved_job.run_id
        run_id_occurrences[base_run_id] = run_id_occurrences.get(base_run_id, 0) + 1
        if run_id_occurrences[base_run_id] > 1:
            dedup_run_id = f'{base_run_id}__dup{run_id_occurrences[base_run_id]}'
            resolved_job = _retarget_job_run_id(
                job=resolved_job,
                save_root=save_root,
                new_run_id=dedup_run_id,
            )
        resolved_jobs.append(resolved_job)
        model_path_by_run_id[resolved_job.run_id] = model_path

    resolved_override_maps = _validate_override_policy(
        jobs=resolved_jobs,
        validation_cfg=validation_cfg,
        safety_cfg=suite_cfg.safety,
    )
    _validate_run_ids(
        jobs=resolved_jobs,
        override_maps=resolved_override_maps,
        safety_cfg=suite_cfg.safety,
    )

    env = os.environ.copy()
    for key, value in _as_dict(suite_cfg.thread_env).items():
        env[str(key)] = str(value)
    env['PYTHONUNBUFFERED'] = '1'

    total_jobs = len(resolved_jobs)
    executed = 0
    skipped = 0
    watchdog_timeouts = 0
    failed_jobs: List[Tuple[str, Optional[int], str]] = []

    jobs_to_run: List[Tuple[int, PlannedJob, Optional[Path]]] = []
    for idx, job in enumerate(resolved_jobs, start=1):
        eval_job = job
        model_path = model_path_by_run_id.get(job.run_id)

        dataset_dir = Path(eval_job.dataset_dir)
        if not dataset_dir.exists():
            raise PreflightFailure(
                f'[eval] missing dataset for {eval_job.run_id}: {dataset_dir}. '
                'Run --stage generate-datasets first.'
            )

        if resume and _is_eval_job_completed(job=eval_job, save_root=save_root):
            skipped += 1
            print(
                f'[eval] skip ({idx}/{total_jobs}) run_id={eval_job.run_id} '
                f'model={model_path or "n/a"}'
            )
            continue

        if not resume:
            effective_run_id = _next_eval_attempt_run_id(job=eval_job, save_root=save_root)
            if effective_run_id != eval_job.run_id:
                eval_job = _retarget_job_run_id(
                    job=eval_job,
                    save_root=save_root,
                    new_run_id=effective_run_id,
                )
                model_path_by_run_id[eval_job.run_id] = model_path
                print(
                    f'[eval] rerun detected for {job.run_id}; '
                    f'using unique attempt run_id={eval_job.run_id}'
                )

        jobs_to_run.append((idx, eval_job, model_path))

    if not jobs_to_run:
        print('[eval] nothing to run after resume checks')
        print(
            f'[eval] profile={selected_profile} jobs={total_jobs} '
            f'executed={executed} skipped={skipped} run_timeouts={watchdog_timeouts}'
        )
        return 0

    parallelism = min(parallelism, len(jobs_to_run))
    if parallelism == 1:
        for idx, eval_job, model_path in jobs_to_run:
            run_dir = _job_run_dir(save_root, eval_job)
            print(f'[eval] run ({idx}/{total_jobs}) run_id={eval_job.run_id}')
            outcome = _run_eval_job_worker(
                job=eval_job,
                run_dir=run_dir,
                env=env,
                watchdog_timeout_sec=watchdog_timeout_sec,
                model_path=model_path,
            )
            run_timeout = bool(outcome.get('run_timeout', False))
            run_failed = bool(outcome.get('run_failed', False))
            returncode_raw = outcome.get('returncode')
            returncode = int(returncode_raw) if returncode_raw is not None else None
            failure_reason = str(outcome.get('failure_reason', ''))
            if run_timeout:
                watchdog_timeouts += 1
            if run_failed:
                failed_jobs.append((eval_job.run_id, returncode, failure_reason))
            executed += 1
            print(
                f'[eval] done ({idx}/{total_jobs}) run_id={eval_job.run_id} '
                f'run_timeout={run_timeout} run_failed={run_failed} returncode={returncode}'
            )
    else:
        print(f'[eval] running with parallelism={parallelism}')
        with ThreadPoolExecutor(max_workers=parallelism) as executor:
            future_to_job: Dict[Any, Tuple[int, PlannedJob, Optional[Path]]] = {}
            for idx, eval_job, model_path in jobs_to_run:
                run_dir = _job_run_dir(save_root, eval_job)
                print(f'[eval] run ({idx}/{total_jobs}) run_id={eval_job.run_id}')
                future = executor.submit(
                    _run_eval_job_worker,
                    eval_job,
                    run_dir,
                    env,
                    watchdog_timeout_sec,
                    model_path,
                )
                future_to_job[future] = (idx, eval_job, model_path)

            for future in as_completed(future_to_job):
                idx, eval_job, _model_path = future_to_job[future]
                try:
                    outcome = future.result()
                    run_timeout = bool(outcome.get('run_timeout', False))
                    run_failed = bool(outcome.get('run_failed', False))
                    returncode_raw = outcome.get('returncode')
                    returncode = int(returncode_raw) if returncode_raw is not None else None
                    failure_reason = str(outcome.get('failure_reason', ''))
                except Exception as exc:
                    run_timeout = False
                    run_failed = True
                    returncode = None
                    failure_reason = str(exc)
                if run_timeout:
                    watchdog_timeouts += 1
                if run_failed:
                    failed_jobs.append((eval_job.run_id, returncode, failure_reason))
                executed += 1
                print(
                    f'[eval] done ({idx}/{total_jobs}) run_id={eval_job.run_id} '
                    f'run_timeout={run_timeout} run_failed={run_failed} returncode={returncode}'
                )

    if failed_jobs:
        print('[eval] completed with failures')
        print(
            f'[eval] profile={selected_profile} jobs={total_jobs} '
            f'executed={executed} skipped={skipped} run_timeouts={watchdog_timeouts} '
            f'failed={len(failed_jobs)}'
        )
        for run_id, returncode, reason in failed_jobs:
            reason_text = reason if reason else 'unknown_failure'
            print(
                f'[eval] failed_run run_id={run_id} returncode={returncode} '
                f'reason={reason_text}'
            )
        return 1

    print('[eval] success')
    print(
        f'[eval] profile={selected_profile} jobs={total_jobs} '
        f'executed={executed} skipped={skipped} run_timeouts={watchdog_timeouts}'
    )
    return 0


def run_aggregate(
    config_path: Path,
    profile_name: Optional[str],
) -> int:
    _global_cfg, suite_cfg = _load_suite_config(config_path)
    _validate_profile_matrix_contracts(suite_cfg)
    selected_profile, _profile_cfg = _profile_or_default(suite_cfg, profile_name)

    suite_root = _resolve_path(str(suite_cfg.paths.suite_root), REPO_ROOT)
    results_root = _resolve_path(str(suite_cfg.paths.save_root_dir), REPO_ROOT)
    tables_dir_raw = suite_cfg.paths.get('tables_dir')
    tables_dir = (
        _resolve_path(str(tables_dir_raw), REPO_ROOT)
        if tables_dir_raw is not None
        else suite_root / 'tables'
    )

    aggregation_cfg = suite_cfg.get('aggregation', OmegaConf.create({}))
    confidence_level = float(aggregation_cfg.get('confidence_level', 0.95))
    bootstrap_samples = int(aggregation_cfg.get('bootstrap_samples', 2000))
    if not (0.0 < confidence_level < 1.0):
        raise ValueError(
            f'aggregation.confidence_level must be in (0, 1), got {confidence_level}'
        )
    if bootstrap_samples <= 0:
        raise ValueError(
            f'aggregation.bootstrap_samples must be > 0, got {bootstrap_samples}'
        )

    aggregate_script = REPO_ROOT / 'tools' / 'aggregate_journal_results.py'
    if not aggregate_script.exists():
        raise PreflightFailure(f'Aggregation script is missing: {aggregate_script}')

    env = os.environ.copy()
    env['PYTHONUNBUFFERED'] = '1'
    for key, value in _as_dict(suite_cfg.thread_env).items():
        env[str(key)] = str(value)

    cmd = [
        sys.executable,
        str(aggregate_script),
        '--suite-root',
        str(suite_root),
        '--results-root',
        str(results_root),
        '--tables-dir',
        str(tables_dir),
        '--confidence-level',
        f'{confidence_level}',
        '--bootstrap-samples',
        str(bootstrap_samples),
    ]

    print(
        f'[aggregate] run profile={selected_profile} '
        f'results_root={results_root} tables_dir={tables_dir}'
    )
    result = subprocess.run(
        cmd,
        cwd=str(REPO_ROOT),
        env=env,
        check=False,
        text=True,
    )
    if result.returncode != 0:
        raise RuntimeError(
            f'[aggregate] failed with exit code {result.returncode}. '
            f'Command: {shlex.join(cmd)}'
        )

    expected_tables = (
        'main_metrics.csv',
        'runtime_metrics.csv',
        'k_ablation.csv',
        'pairwise_deltas.csv',
        'significance.csv',
        'ranked_summary.csv',
    )
    missing_tables = [name for name in expected_tables if not (tables_dir / name).exists()]
    if missing_tables:
        raise RuntimeError(
            '[aggregate] completed but missing expected tables: '
            + ', '.join(sorted(missing_tables))
        )

    print('[aggregate] success')
    print(f'[aggregate] profile={selected_profile} tables={tables_dir}')
    return 0


def run_preflight(config_path: Path, profile_name: Optional[str]) -> int:
    global_cfg, suite_cfg = _load_suite_config(config_path)
    matrix_contract = _validate_profile_matrix_contracts(suite_cfg)
    selected_profile, profile_cfg = _profile_or_default(suite_cfg, profile_name)
    jobs = _build_planned_jobs(suite_cfg=suite_cfg, profile_cfg=profile_cfg, repo_root=REPO_ROOT)
    if not jobs:
        raise PreflightFailure('No planned jobs generated from profile')

    _validate_topologies_exist(jobs)
    _validate_solver_names(suite_cfg, profile_cfg)
    validation_cfg = _compose_validation_base(global_cfg, REPO_ROOT / 'settings')

    override_maps = _validate_override_policy(
        jobs=jobs,
        validation_cfg=validation_cfg,
        safety_cfg=suite_cfg.safety,
    )
    _validate_run_ids(jobs=jobs, override_maps=override_maps, safety_cfg=suite_cfg.safety)
    paired_matching = _validate_paired_matching_policy(
        jobs=jobs,
        suite_cfg=suite_cfg,
        profile_cfg=profile_cfg,
    )
    pn_precedence = _check_pn_load_precedence(validation_cfg=validation_cfg, suite_cfg=suite_cfg)
    offline_slice_compatibility = _check_offline_slice_compatibility(
        suite_cfg=suite_cfg,
        profile_cfg=profile_cfg,
        validation_cfg=validation_cfg,
    )
    k_semantics_parity = _check_k_semantics_parity(
        suite_cfg=suite_cfg,
        profile_cfg=profile_cfg,
        validation_cfg=validation_cfg,
    )

    manifest_path = _resolve_path(str(suite_cfg.paths.manifest_path), REPO_ROOT)
    _write_manifest(
        manifest_path=manifest_path,
        global_cfg=global_cfg,
        suite_cfg=suite_cfg,
        profile_name=selected_profile,
        jobs=jobs,
        pn_precedence=pn_precedence,
        matrix_contract=matrix_contract,
        paired_matching_policy=paired_matching,
        offline_slice_compatibility=offline_slice_compatibility,
        k_semantics_parity=k_semantics_parity,
    )

    train_jobs = sum(1 for job in jobs if job.stage == 'train')
    eval_jobs = sum(1 for job in jobs if job.stage == 'eval')
    print('[preflight] success')
    print(f'[preflight] profile={selected_profile} jobs={len(jobs)} train={train_jobs} eval={eval_jobs}')
    if paired_matching.get('status') == 'enforced':
        print(
            '[preflight] paired_matching='
            f"methods={len(paired_matching['method_keys'])} "
            f"cells={paired_matching['matched_cell_count']}"
        )
    if offline_slice_compatibility.get('enabled'):
        print(
            '[preflight] offline_slice='
            f"methods={len(offline_slice_compatibility.get('method_keys', []))} "
            f"topologies={len(offline_slice_compatibility.get('topologies', []))} "
            f"k={len(offline_slice_compatibility.get('k_eval_values', []))}"
        )
    if k_semantics_parity.get('enabled') and k_semantics_parity.get('status') == 'enforced':
        print(
            '[preflight] k_semantics_parity='
            f"methods={k_semantics_parity['method_count']} "
            f"k_fail={k_semantics_parity['fail_k_value']} "
            f"k_success={k_semantics_parity['success_k_value']}"
        )
    print(f'[preflight] manifest={manifest_path}')
    return 0


def run_generate_datasets(
    config_path: Path,
    profile_name: Optional[str],
    force: bool = False,
) -> int:
    global_cfg, suite_cfg = _load_suite_config(config_path)
    _validate_profile_matrix_contracts(suite_cfg)
    selected_profile, profile_cfg = _profile_or_default(suite_cfg, profile_name)
    dataset_specs = _build_dataset_specs(
        suite_cfg=suite_cfg,
        profile_cfg=profile_cfg,
        repo_root=REPO_ROOT,
    )
    if not dataset_specs:
        raise PreflightFailure('No dataset specs generated from profile')

    _validate_dataset_topologies_exist(dataset_specs)
    validation_cfg = _compose_validation_base(global_cfg, REPO_ROOT / 'settings')
    offline_plan = _resolve_offline_slice_plan(suite_cfg, profile_cfg)
    offline_selectors, offline_suffix = _offline_slice_dataset_selector(suite_cfg, profile_cfg)

    dataset_results: List[Dict[str, Any]] = []
    offline_slice_results: List[Dict[str, Any]] = []
    for dataset_spec in dataset_specs:
        scenario_cfg = suite_cfg.scenarios[dataset_spec.scenario_key]
        generation_cfg = _build_dataset_generation_config(
            validation_cfg=validation_cfg,
            dataset_spec=dataset_spec,
            scenario_cfg=scenario_cfg,
        )
        result = _materialize_dataset(
            dataset_spec=dataset_spec,
            generation_cfg=generation_cfg,
            force=force,
        )
        dataset_results.append(result)
        print(
            f"[datasets] {result['status']} "
            f"{result['scenario']}/{result['topology']}/seed_{result['seed']}/{result['split']} "
            f"-> {result['dataset_dir']}"
        )

        selector_key = (
            dataset_spec.scenario_key,
            dataset_spec.topology_key,
            dataset_spec.seed,
            dataset_spec.split,
        )
        if selector_key in offline_selectors:
            source_dataset_dir = Path(dataset_spec.dataset_dir)
            target_dataset_dir = _build_offline_dataset_dir(
                source_dataset_dir,
                suffix=offline_suffix,
            )
            offline_result = _materialize_offline_slice_dataset(
                source_dataset_dir=source_dataset_dir,
                target_dataset_dir=target_dataset_dir,
                generation_cfg=generation_cfg,
                validation_cfg=validation_cfg,
                seed=dataset_spec.seed,
                force=force,
                conversion_enabled=offline_plan.conversion_enabled,
            )
            offline_slice_results.append(offline_result)
            print(
                f"[datasets] offline_slice {offline_result['status']} "
                f"{dataset_spec.scenario_key}/{dataset_spec.topology_key}/seed_{dataset_spec.seed}/{dataset_spec.split} "
                f"-> {offline_result['offline_dataset_dir']}"
            )

    suite_root = _resolve_path(str(suite_cfg.paths.suite_root), REPO_ROOT)
    dataset_manifest_path = suite_root / 'dataset_generation_manifest.json'
    _write_dataset_manifest(
        manifest_path=dataset_manifest_path,
        global_cfg=global_cfg,
        suite_cfg=suite_cfg,
        profile_name=selected_profile,
        dataset_results=dataset_results,
        offline_slice_results=offline_slice_results,
        force=force,
    )

    generated_count = sum(
        1
        for result in dataset_results
        if result.get('status') in {'generated', 'regenerated'}
    )
    reused_count = sum(1 for result in dataset_results if result.get('status') == 'reused')
    print('[datasets] success')
    print(
        f'[datasets] profile={selected_profile} datasets={len(dataset_results)} '
        f'generated_or_regenerated={generated_count} reused={reused_count} '
        f'offline_slice_datasets={len(offline_slice_results)}'
    )
    print(f'[datasets] manifest={dataset_manifest_path}')
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description='Journal experiment orchestrator (preflight + dataset generation + train + eval + aggregate stages).'
    )
    parser.add_argument(
        '--config',
        default='settings/experiments/journal_suite.yaml',
        help='Path to the journal suite config YAML.',
    )
    parser.add_argument(
        '--stage',
        default='preflight',
        choices=['preflight', 'generate-datasets', 'train', 'eval', 'aggregate', 'all'],
        help='Pipeline stage. Implemented stages: preflight, generate-datasets, train, eval, aggregate, all.',
    )
    parser.add_argument(
        '--profile',
        default=None,
        help='Profile key from journal_suite.profiles. Defaults to journal_suite.default_profile.',
    )
    parser.add_argument(
        '--force',
        action='store_true',
        help='Allow regenerating datasets for --stage generate-datasets.',
    )
    parser.add_argument(
        '--resume',
        action='store_true',
        help='For --stage train/eval, skip completed runs and reuse existing outputs.',
    )
    return parser


def main(argv: Optional[Sequence[str]] = None) -> int:
    args = build_parser().parse_args(argv)
    config_path = _resolve_path(args.config, REPO_ROOT)

    if args.stage == 'preflight':
        return run_preflight(config_path=config_path, profile_name=args.profile)
    if args.stage == 'generate-datasets':
        return run_generate_datasets(
            config_path=config_path,
            profile_name=args.profile,
            force=bool(args.force),
        )
    if args.stage == 'train':
        return run_train(
            config_path=config_path,
            profile_name=args.profile,
            resume=bool(args.resume),
        )
    if args.stage == 'eval':
        return run_eval(
            config_path=config_path,
            profile_name=args.profile,
            resume=bool(args.resume),
        )
    if args.stage == 'aggregate':
        return run_aggregate(
            config_path=config_path,
            profile_name=args.profile,
        )
    if args.stage == 'all':
        run_preflight(config_path=config_path, profile_name=args.profile)
        run_generate_datasets(
            config_path=config_path,
            profile_name=args.profile,
            force=bool(args.force),
        )
        run_train(
            config_path=config_path,
            profile_name=args.profile,
            resume=bool(args.resume),
        )
        run_eval(
            config_path=config_path,
            profile_name=args.profile,
            resume=bool(args.resume),
        )
        return run_aggregate(
            config_path=config_path,
            profile_name=args.profile,
        )

    raise NotImplementedError(
        f"Stage '{args.stage}' is not implemented in this orchestrator yet. "
        'Use --stage preflight, --stage generate-datasets, --stage train, --stage eval, or --stage aggregate.'
    )


if __name__ == '__main__':
    raise SystemExit(main())
