from __future__ import annotations

import importlib.util
import json
from pathlib import Path
import sys
import warnings

import pytest
from omegaconf import OmegaConf


REPO_ROOT = Path(__file__).resolve().parents[2]
MODULE_PATH = REPO_ROOT / 'tools' / 'journal_experiments.py'

warnings.filterwarnings(
    'ignore',
    message='CUDA initialization: .*',
    category=UserWarning,
)

_SPEC = importlib.util.spec_from_file_location('journal_experiments', MODULE_PATH)
assert _SPEC is not None and _SPEC.loader is not None
journal_experiments = importlib.util.module_from_spec(_SPEC)
sys.modules[_SPEC.name] = journal_experiments
_SPEC.loader.exec_module(journal_experiments)


def _load_smoke_profile():
    config_path = REPO_ROOT / 'settings' / 'experiments' / 'journal_suite.yaml'
    global_cfg, suite_cfg = journal_experiments._load_suite_config(config_path)
    _, profile_cfg = journal_experiments._profile_or_default(suite_cfg, 'smoke')
    return global_cfg, suite_cfg, profile_cfg


def _make_train_job(
    *,
    run_id: str,
    dataset_dir: Path,
    solver_name: str = 'alpha_zero_sfc',
    method_key: str = 'alpha_zero_sfc',
) -> journal_experiments.PlannedJob:
    save_root = dataset_dir.parent / 'results'
    hydra_dir = save_root / solver_name / run_id / 'hydra'
    overrides = (
        f'solver.solver_name={solver_name}',
        'solver.k_shortest=10',
        'experiment.seed=0',
        'training.seed=0',
        f'experiment.run_id={run_id}',
        f'experiment.save_root_dir={save_root}',
        f'hydra.run.dir={hydra_dir}',
        f'simulation.p_net_dataset_dir={dataset_dir}',
        f'simulation.v_nets_dataset_dir={dataset_dir}',
    )
    return journal_experiments.PlannedJob(
        stage='train',
        method_key=method_key,
        solver_name=solver_name,
        topology_key='wx100',
        scenario_key='nominal',
        dataset_scenario_key='nominal',
        train_source_scenario_key=None,
        seed=0,
        k_value=10,
        run_id=run_id,
        dataset_dir=str(dataset_dir),
        source_dataset_dir=None,
        is_offline_slice=False,
        topology_file_path='datasets/topology/Waxman100.gml',
        overrides=overrides,
    )


def _make_eval_job(
    *,
    run_id: str,
    dataset_dir: Path,
    solver_name: str = 'alpha_zero_sfc',
    method_key: str = 'alpha_zero_sfc',
) -> journal_experiments.PlannedJob:
    save_root = dataset_dir.parent / 'results'
    hydra_dir = save_root / solver_name / run_id / 'hydra'
    overrides = (
        f'solver.solver_name={solver_name}',
        'solver.k_shortest=5',
        'experiment.seed=0',
        'training.seed=0',
        f'experiment.run_id={run_id}',
        f'experiment.save_root_dir={save_root}',
        f'hydra.run.dir={hydra_dir}',
        f'simulation.p_net_dataset_dir={dataset_dir}',
        f'simulation.v_nets_dataset_dir={dataset_dir}',
        'use_fixed_dataset=true',
        'experiment.if_load_p_net=true',
        'experiment.if_load_v_nets=true',
        'training.inference_only=true',
        'training.num_train_epochs=0',
    )
    return journal_experiments.PlannedJob(
        stage='eval',
        method_key=method_key,
        solver_name=solver_name,
        topology_key='wx100',
        scenario_key='nominal',
        dataset_scenario_key='nominal',
        train_source_scenario_key=None,
        seed=0,
        k_value=5,
        run_id=run_id,
        dataset_dir=str(dataset_dir),
        source_dataset_dir=None,
        is_offline_slice=False,
        topology_file_path='datasets/topology/Waxman100.gml',
        overrides=overrides,
    )


def test_build_planned_jobs_includes_offline_slice_rows() -> None:
    _, suite_cfg, profile_cfg = _load_smoke_profile()
    jobs = journal_experiments._build_planned_jobs(
        suite_cfg=suite_cfg,
        profile_cfg=profile_cfg,
        repo_root=REPO_ROOT,
    )

    offline_jobs = [job for job in jobs if job.is_offline_slice]
    assert len(offline_jobs) == 6
    assert all(job.stage == 'eval' for job in offline_jobs)
    assert all('__offline__' in job.run_id for job in offline_jobs)
    assert all(job.source_dataset_dir is not None for job in offline_jobs)
    assert all(job.dataset_dir.endswith('__offline') for job in offline_jobs)
    assert all(
        'system.if_offline_system=true' in job.overrides
        for job in offline_jobs
    )


def test_preflight_k_semantics_parity_smoke_profile() -> None:
    global_cfg, suite_cfg, profile_cfg = _load_smoke_profile()
    validation_cfg = journal_experiments._compose_validation_base(
        global_cfg,
        REPO_ROOT / 'settings',
    )
    result = journal_experiments._check_k_semantics_parity(
        suite_cfg=suite_cfg,
        profile_cfg=profile_cfg,
        validation_cfg=validation_cfg,
    )

    assert result['enabled'] is True
    assert result['status'] == 'enforced'
    assert result['method_count'] == 3
    for method_key in ('alpha_zero_sfc', 'mcts', 'grc_rank'):
        method_result = result['results'][method_key]
        assert method_result['k_fail_result'] is False
        assert method_result['k_success_result'] is True


def test_merge_model_registry_deduplicates_and_prefers_shard_rows(tmp_path: Path) -> None:
    registry_path = tmp_path / 'model_registry.csv'
    shards_dir = tmp_path / 'model_registry_shards'
    shards_dir.mkdir(parents=True, exist_ok=True)

    registry_path.write_text(
        '\n'.join(
            [
                ','.join(journal_experiments.MODEL_REGISTRY_COLUMNS),
                'alpha_zero_sfc,alpha_zero_sfc,wx100,nominal,0,10,/old/model.pt,run_a,2026-01-01T00:00:00+00:00',
            ]
        )
        + '\n',
        encoding='utf-8',
    )

    shard_a = {
        'method': 'alpha_zero_sfc',
        'solver_name': 'alpha_zero_sfc',
        'topology': 'wx100',
        'scenario': 'nominal',
        'seed': '0',
        'k_train': '10',
        'model_path': str(tmp_path / 'new-model-a.pt'),
        'run_id': 'run_a',
        'updated_at_utc': '2026-02-19T00:00:00+00:00',
    }
    shard_b = dict(shard_a)
    shard_b.update({'run_id': 'run_b', 'model_path': str(tmp_path / 'new-model-b.pt')})

    (shards_dir / 'run_a.json').write_text(json.dumps(shard_a), encoding='utf-8')
    (shards_dir / 'run_b.json').write_text(json.dumps(shard_b), encoding='utf-8')

    row_count = journal_experiments._merge_model_registry(
        registry_path=registry_path,
        shards_dir=shards_dir,
    )

    assert row_count == 2
    rows = registry_path.read_text(encoding='utf-8').strip().splitlines()
    assert len(rows) == 3
    assert 'run_a' in rows[1] or 'run_a' in rows[2]
    assert 'run_b' in rows[1] or 'run_b' in rows[2]
    assert str(tmp_path / 'new-model-a.pt') in registry_path.read_text(encoding='utf-8')


def test_run_train_resume_skips_completed_job_and_writes_registry(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    dataset_dir = tmp_path / 'datasets' / 'train'
    dataset_dir.mkdir(parents=True, exist_ok=True)
    run_id = 'journal_suite__alpha_zero_sfc__wx100__nominal__seed0__train__ktrain10'
    job = _make_train_job(run_id=run_id, dataset_dir=dataset_dir)

    save_root = tmp_path / 'results'
    suite_root = tmp_path / 'suite'
    global_cfg = OmegaConf.create({})
    suite_cfg = OmegaConf.create(
        {
            'paths': {
                'save_root_dir': str(save_root),
                'suite_root': str(suite_root),
            },
            'thread_env': {},
            'safety': {'run_id_tokens': {'train': '__train__', 'eval': '__eval__', 'offline': '__offline__'}},
        }
    )

    model_path = tmp_path / 'existing-model.pt'
    model_path.write_text('ok', encoding='utf-8')

    monkeypatch.setattr(
        journal_experiments,
        '_load_suite_config',
        lambda _config_path: (global_cfg, suite_cfg),
    )
    monkeypatch.setattr(journal_experiments, '_validate_profile_matrix_contracts', lambda _suite_cfg: {})
    monkeypatch.setattr(
        journal_experiments,
        '_profile_or_default',
        lambda _suite_cfg, _profile_name: ('unit', OmegaConf.create({})),
    )
    monkeypatch.setattr(journal_experiments, '_build_planned_jobs', lambda **_kwargs: [job])
    monkeypatch.setattr(journal_experiments, '_compose_validation_base', lambda *_args, **_kwargs: OmegaConf.create({}))
    monkeypatch.setattr(
        journal_experiments,
        '_validate_override_policy',
        lambda jobs, **_kwargs: {jobs[0].run_id: {'experiment.run_id': jobs[0].run_id}},
    )
    monkeypatch.setattr(journal_experiments, '_validate_run_ids', lambda **_kwargs: None)
    monkeypatch.setattr(
        journal_experiments,
        '_is_train_job_completed',
        lambda **_kwargs: (True, model_path),
    )

    def _unexpected_train_call(**_kwargs):
        raise AssertionError('train subprocess should not run when resume skip is active')

    monkeypatch.setattr(journal_experiments, '_run_train_job_subprocess', _unexpected_train_call)

    rc = journal_experiments.run_train(
        config_path=tmp_path / 'journal_suite.yaml',
        profile_name='unit',
        resume=True,
    )
    assert rc == 0

    registry_path = suite_root / 'model_registry.csv'
    assert registry_path.exists()
    registry_text = registry_path.read_text(encoding='utf-8')
    assert run_id in registry_text
    assert str(model_path.resolve()) in registry_text


def test_run_train_uses_unique_attempt_run_id_for_retrain(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    dataset_dir = tmp_path / 'datasets' / 'train'
    dataset_dir.mkdir(parents=True, exist_ok=True)
    base_run_id = 'journal_suite__alpha_zero_sfc__wx100__nominal__seed0__train__ktrain10'
    job = _make_train_job(run_id=base_run_id, dataset_dir=dataset_dir)

    save_root = tmp_path / 'results'
    suite_root = tmp_path / 'suite'
    existing_run_dir = save_root / 'alpha_zero_sfc' / base_run_id
    existing_run_dir.mkdir(parents=True, exist_ok=True)
    (existing_run_dir / 'summary.csv').write_text('ok\n', encoding='utf-8')

    global_cfg = OmegaConf.create({})
    suite_cfg = OmegaConf.create(
        {
            'paths': {
                'save_root_dir': str(save_root),
                'suite_root': str(suite_root),
            },
            'thread_env': {},
            'safety': {'run_id_tokens': {'train': '__train__', 'eval': '__eval__', 'offline': '__offline__'}},
        }
    )

    monkeypatch.setattr(
        journal_experiments,
        '_load_suite_config',
        lambda _config_path: (global_cfg, suite_cfg),
    )
    monkeypatch.setattr(journal_experiments, '_validate_profile_matrix_contracts', lambda _suite_cfg: {})
    monkeypatch.setattr(
        journal_experiments,
        '_profile_or_default',
        lambda _suite_cfg, _profile_name: ('unit', OmegaConf.create({})),
    )
    monkeypatch.setattr(journal_experiments, '_build_planned_jobs', lambda **_kwargs: [job])
    monkeypatch.setattr(journal_experiments, '_compose_validation_base', lambda *_args, **_kwargs: OmegaConf.create({}))
    monkeypatch.setattr(
        journal_experiments,
        '_validate_override_policy',
        lambda jobs, **_kwargs: {jobs[0].run_id: {'experiment.run_id': jobs[0].run_id}},
    )
    monkeypatch.setattr(journal_experiments, '_validate_run_ids', lambda **_kwargs: None)
    monkeypatch.setattr(journal_experiments, '_is_train_job_completed', lambda **_kwargs: (False, None))

    seen_run_ids: list[str] = []

    def _fake_run_train_job_subprocess(*, job, run_dir, env):
        seen_run_ids.append(job.run_id)
        model_dir = run_dir / 'models'
        model_dir.mkdir(parents=True, exist_ok=True)
        (model_dir / 'policy_latest.pt').write_text('weights', encoding='utf-8')
        (run_dir / 'summary.csv').write_text('ok\n', encoding='utf-8')

    monkeypatch.setattr(journal_experiments, '_run_train_job_subprocess', _fake_run_train_job_subprocess)

    rc = journal_experiments.run_train(
        config_path=tmp_path / 'journal_suite.yaml',
        profile_name='unit',
        resume=False,
    )
    assert rc == 0
    assert seen_run_ids == [f'{base_run_id}__attempt1']

    registry_path = suite_root / 'model_registry.csv'
    assert registry_path.exists()
    registry_text = registry_path.read_text(encoding='utf-8')
    assert f'{base_run_id}__attempt1' in registry_text
    assert f'{base_run_id},' not in registry_text


def test_run_eval_attaches_model_and_writes_completion_marker(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    dataset_dir = tmp_path / 'datasets' / 'eval'
    dataset_dir.mkdir(parents=True, exist_ok=True)
    run_id = 'journal_suite__alpha_zero_sfc__wx100__nominal__seed0__eval__keval5__ckptlatest'
    job = _make_eval_job(run_id=run_id, dataset_dir=dataset_dir)

    model_path = (tmp_path / 'trained-model.pt').resolve()
    model_path.write_text('weights', encoding='utf-8')

    save_root = tmp_path / 'results'
    suite_root = tmp_path / 'suite'
    registry_path = suite_root / 'model_registry.csv'
    shard_dir = suite_root / 'model_registry_shards'
    global_cfg = OmegaConf.create({})
    suite_cfg = OmegaConf.create(
        {
            'paths': {
                'save_root_dir': str(save_root),
                'suite_root': str(suite_root),
            },
            'thread_env': {},
            'safety': {'run_id_tokens': {'train': '__train__', 'eval': '__eval__', 'offline': '__offline__'}},
            'methods': {
                'alpha_zero_sfc': {'trainable': True, 'train_k_values': [10]},
            },
            'evaluation': {
                'request_timeout_sec': 11.0,
                'run_watchdog_timeout_sec': 22.0,
                'record_arrival_solve_time': True,
                'gpu_synchronize_timing': True,
            },
        }
    )

    monkeypatch.setattr(
        journal_experiments,
        '_load_suite_config',
        lambda _config_path: (global_cfg, suite_cfg),
    )
    monkeypatch.setattr(journal_experiments, '_validate_profile_matrix_contracts', lambda _suite_cfg: {})
    monkeypatch.setattr(
        journal_experiments,
        '_profile_or_default',
        lambda _suite_cfg, _profile_name: ('unit', OmegaConf.create({})),
    )
    monkeypatch.setattr(journal_experiments, '_build_planned_jobs', lambda **_kwargs: [job])
    monkeypatch.setattr(journal_experiments, '_compose_validation_base', lambda *_args, **_kwargs: OmegaConf.create({}))
    monkeypatch.setattr(
        journal_experiments,
        '_validate_override_policy',
        lambda jobs, **_kwargs: {j.run_id: {'experiment.run_id': j.run_id} for j in jobs},
    )
    monkeypatch.setattr(journal_experiments, '_validate_run_ids', lambda **_kwargs: None)
    monkeypatch.setattr(
        journal_experiments,
        '_resolve_train_registry_paths',
        lambda _suite_cfg: (registry_path, shard_dir),
    )
    monkeypatch.setattr(journal_experiments, '_merge_model_registry', lambda **_kwargs: 1)
    monkeypatch.setattr(
        journal_experiments,
        '_read_model_registry_rows',
        lambda **_kwargs: [
            {
                'method': 'alpha_zero_sfc',
                'solver_name': 'alpha_zero_sfc',
                'topology': 'wx100',
                'scenario': 'nominal',
                'seed': '0',
                'k_train': '10',
                'model_path': str(model_path),
                'run_id': 'train_a',
                'updated_at_utc': '2026-01-01T00:00:00+00:00',
            }
        ],
    )

    seen_jobs: list[journal_experiments.PlannedJob] = []

    def _fake_eval_subprocess(*, job, run_dir, env, watchdog_timeout_sec):
        seen_jobs.append(job)
        run_dir.mkdir(parents=True, exist_ok=True)
        (run_dir / 'summary.csv').write_text('run_id,acceptance_rate\nx,0.0\n', encoding='utf-8')
        return {'run_timeout': False, 'returncode': 0}

    monkeypatch.setattr(journal_experiments, '_run_eval_job_subprocess', _fake_eval_subprocess)

    rc = journal_experiments.run_eval(
        config_path=tmp_path / 'journal_suite.yaml',
        profile_name='unit',
        resume=False,
    )

    assert rc == 0
    assert len(seen_jobs) == 1
    seen_job = seen_jobs[0]
    assert '__ckptlatest' not in seen_job.run_id
    assert '__ckpt' in seen_job.run_id

    override_map = {}
    for raw in seen_job.overrides:
        spec = journal_experiments._parse_override(raw)
        override_map[spec.key] = spec.value

    assert override_map['solver.pretrained_model_path'] == str(model_path)
    assert override_map['experiment.request_timeout_sec'] == '11.0'
    assert override_map['experiment.run_watchdog_timeout_sec'] == '22.0'
    assert override_map['training.enable_async_learner'] == 'false'

    marker_path = (
        save_root
        / seen_job.solver_name
        / seen_job.run_id
        / 'eval_completed.json'
    )
    assert marker_path.exists()


def test_validate_run_ids_rejects_solver_run_id_collision() -> None:
    train_job = _make_train_job(
        run_id='journal_suite__alpha_zero_sfc__wx100__nominal__seed0__train__ktrain10',
        dataset_dir=Path('/tmp/dataset-a'),
    )
    eval_job = journal_experiments.replace(
        train_job,
        stage='eval',
    )

    override_maps = {
        train_job.run_id: {'experiment.run_id': train_job.run_id},
        eval_job.run_id: {'experiment.run_id': eval_job.run_id},
    }
    safety_cfg = OmegaConf.create(
        {'run_id_tokens': {'train': '__train__', 'eval': '__eval__', 'offline': '__offline__'}}
    )

    with pytest.raises(journal_experiments.PreflightFailure, match='duplicate solver/run_id pair'):
        journal_experiments._validate_run_ids(
            jobs=[train_job, eval_job],
            override_maps=override_maps,
            safety_cfg=safety_cfg,
        )


def test_resolve_eval_job_attaches_model_and_runtime_overrides(tmp_path: Path) -> None:
    _, suite_cfg, profile_cfg = _load_smoke_profile()
    jobs = journal_experiments._build_planned_jobs(
        suite_cfg=suite_cfg,
        profile_cfg=profile_cfg,
        repo_root=REPO_ROOT,
    )
    eval_job = next(
        job
        for job in jobs
        if job.stage == 'eval'
        and job.method_key == 'alpha_zero_sfc'
        and not job.is_offline_slice
    )

    model_path = (tmp_path / 'policy_latest.pt').resolve()
    model_path.write_bytes(b'unit-test-model')
    registry_rows = [
        {
            'method': 'alpha_zero_sfc',
            'solver_name': 'alpha_zero_sfc',
            'topology': eval_job.topology_key,
            'scenario': eval_job.scenario_key,
            'seed': str(eval_job.seed),
            'k_train': '10',
            'model_path': str(model_path),
            'run_id': 'train-row',
            'updated_at_utc': '2026-01-01T00:00:00+00:00',
        }
    ]

    save_root = tmp_path / 'results'
    resolved_job, resolved_model_path = journal_experiments._resolve_eval_job(
        job=eval_job,
        suite_cfg=suite_cfg,
        method_cfg=suite_cfg.methods[eval_job.method_key],
        save_root=save_root,
        registry_rows=registry_rows,
    )

    assert resolved_model_path == model_path
    assert '__ckptlatest' not in resolved_job.run_id
    assert '__ckpt' in resolved_job.run_id

    override_map = {}
    for raw in resolved_job.overrides:
        spec = journal_experiments._parse_override(raw)
        override_map[spec.key] = spec.value

    assert override_map['solver.pretrained_model_path'] == str(model_path)
    assert override_map['training.alphazero_model_path'] == str(model_path)
    assert override_map['training.resume_training'] == 'false'
    eval_cfg = suite_cfg.get('evaluation', OmegaConf.create({}))
    assert override_map['experiment.request_timeout_sec'] == str(
        float(eval_cfg.get('request_timeout_sec', 0.0))
    )
    assert override_map['experiment.run_watchdog_timeout_sec'] == str(
        float(eval_cfg.get('run_watchdog_timeout_sec', 0.0))
    )
    assert override_map['experiment.record_arrival_solve_time'] == (
        'true' if bool(eval_cfg.get('record_arrival_solve_time', True)) else 'false'
    )
    assert override_map['experiment.gpu_synchronize_timing'] == (
        'true' if bool(eval_cfg.get('gpu_synchronize_timing', True)) else 'false'
    )
    assert override_map['training.enable_async_learner'] == 'false'


def test_ensure_run_timeout_in_summary_creates_timeout_stub(tmp_path: Path) -> None:
    _, suite_cfg, profile_cfg = _load_smoke_profile()
    jobs = journal_experiments._build_planned_jobs(
        suite_cfg=suite_cfg,
        profile_cfg=profile_cfg,
        repo_root=REPO_ROOT,
    )
    eval_job = next(
        job
        for job in jobs
        if job.stage == 'eval'
        and job.method_key == 'mcts'
        and not job.is_offline_slice
    )

    run_dir = tmp_path / 'results' / eval_job.solver_name / eval_job.run_id
    journal_experiments._ensure_run_timeout_in_summary(
        job=eval_job,
        run_dir=run_dir,
        run_timeout=True,
        watchdog_timeout_sec=123.0,
        elapsed_sec=124.5,
    )

    summary_path = run_dir / 'summary.csv'
    assert summary_path.exists()
    text = summary_path.read_text(encoding='utf-8')
    assert 'run_timeout' in text
    assert 'run_watchdog_timeout_sec' in text
    assert ',1,' in text or text.rstrip().endswith(',1')


def test_resolve_eval_model_path_fails_without_registry_entry() -> None:
    _, suite_cfg, profile_cfg = _load_smoke_profile()
    jobs = journal_experiments._build_planned_jobs(
        suite_cfg=suite_cfg,
        profile_cfg=profile_cfg,
        repo_root=REPO_ROOT,
    )
    eval_job = next(
        job
        for job in jobs
        if job.stage == 'eval'
        and job.method_key == 'alpha_zero_sfc'
        and not job.is_offline_slice
    )

    with pytest.raises(journal_experiments.PreflightFailure):
        journal_experiments._resolve_eval_model_path(
            job=eval_job,
            method_cfg=suite_cfg.methods[eval_job.method_key],
            registry_rows=[],
        )


def test_main_stage_aggregate_dispatches_run_aggregate(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    config_path = tmp_path / 'journal_suite.yaml'
    config_path.write_text('journal_suite: {}\n', encoding='utf-8')

    seen: dict[str, object] = {}

    def _fake_run_aggregate(*, config_path: Path, profile_name: str | None) -> int:
        seen['config_path'] = config_path
        seen['profile_name'] = profile_name
        return 0

    monkeypatch.setattr(journal_experiments, 'run_aggregate', _fake_run_aggregate)

    rc = journal_experiments.main(
        [
            '--config',
            str(config_path),
            '--stage',
            'aggregate',
            '--profile',
            'tiny',
        ]
    )

    assert rc == 0
    assert seen['config_path'] == config_path.resolve()
    assert seen['profile_name'] == 'tiny'


def test_main_stage_all_runs_aggregate_last(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    config_path = tmp_path / 'journal_suite.yaml'
    config_path.write_text('journal_suite: {}\n', encoding='utf-8')

    call_order: list[str] = []

    monkeypatch.setattr(
        journal_experiments,
        'run_preflight',
        lambda **_kwargs: call_order.append('preflight') or 0,
    )
    monkeypatch.setattr(
        journal_experiments,
        'run_generate_datasets',
        lambda **_kwargs: call_order.append('generate-datasets') or 0,
    )
    monkeypatch.setattr(
        journal_experiments,
        'run_train',
        lambda **_kwargs: call_order.append('train') or 0,
    )
    monkeypatch.setattr(
        journal_experiments,
        'run_eval',
        lambda **_kwargs: call_order.append('eval') or 0,
    )
    monkeypatch.setattr(
        journal_experiments,
        'run_aggregate',
        lambda **_kwargs: call_order.append('aggregate') or 0,
    )

    rc = journal_experiments.main(
        [
            '--config',
            str(config_path),
            '--stage',
            'all',
            '--profile',
            'tiny',
        ]
    )

    assert rc == 0
    assert call_order == ['preflight', 'generate-datasets', 'train', 'eval', 'aggregate']
