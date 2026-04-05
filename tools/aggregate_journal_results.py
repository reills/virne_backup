#!/usr/bin/env python3
"""
Aggregate journal experiment outputs into paper-ready tables.

This script scans run-level outputs under:
  results/<solver>/<run_id>/summary.csv
  results/<solver>/<run_id>/records/*.csv

and emits:
  - main_metrics.csv
  - runtime_metrics.csv
  - k_ablation.csv
  - pairwise_deltas.csv
  - significance.csv
  - ranked_summary.csv
"""

from __future__ import annotations

import argparse
import itertools
import math
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Iterable, Optional, Sequence

import numpy as np
import pandas as pd

try:
    from scipy.stats import wilcoxon
except Exception:  # pragma: no cover - optional dependency fallback
    wilcoxon = None


RUNTIME_COLUMNS = (
    'solve_time_sec',
    'solve_time',
    'solve_runtime',
    'solve_latency_sec',
    'request_runtime_sec',
    'request_solve_time',
    'runtime_per_request',
)

TIMEOUT_COLUMNS = (
    'request_timeout',
    'timed_out',
    'timeout',
    'timeout_flag',
    'is_timeout',
)

RUN_TIMEOUT_COLUMNS = (
    'run_timeout',
    'timed_out_run',
    'if_run_timeout',
)

TIMEOUT_COUNT_COLUMNS = (
    'timeout_count',
    'request_timeout_count',
    'timed_out_arrivals',
    'timed_out_count',
)

ARRIVAL_COUNT_COLUMNS = (
    'num_arrival_requests',
    'arrival_count',
    'v_net_count',
)

MAIN_COLUMNS = [
    'method',
    'topology',
    'scenario',
    'k_eval',
    'seeds_n',
    'runs_n',
    'rac_mean',
    'rac_std',
    'lrc_mean',
    'lrc_std',
    'ast_run_mean',
    'ast_req_mean',
    'time_req_mean',
    'time_req_median',
    'time_req_p95',
    'timeout_rate',
    'training_cost',
]

RUNTIME_COLUMNS_OUT = [
    'method',
    'topology',
    'scenario',
    'k_eval',
    'seeds_n',
    'runs_n',
    'ast_run_mean',
    'ast_run_p95',
    'ast_req_mean',
    'ast_req_p95',
    'time_req_mean',
    'time_req_median',
    'time_req_p95',
    'timeout_rate',
    'timeout_rate_p95',
    'training_cost',
]

K_ABLATION_COLUMNS = [
    'method',
    'topology',
    'scenario',
    'k_eval',
    'seeds_n',
    'rac_mean',
    'lrc_mean',
    'ast_req_mean',
    'time_req_p95',
    'timeout_rate',
    'training_cost',
    'baseline_k',
    'delta_rac_vs_baseline',
    'delta_lrc_vs_baseline',
    'speedup_ast_req_vs_baseline',
    'speedup_time_req_p95_vs_baseline',
]

PAIRWISE_COLUMNS = [
    'method_a',
    'method_b',
    'topology',
    'scenario',
    'k_eval',
    'matched_n',
    'delta_rac_mean',
    'delta_lrc_mean',
    'speedup_ast_req_mean',
    'speedup_time_req_p95_mean',
    'win_rate',
]

SIGNIFICANCE_COLUMNS = [
    'method_a',
    'method_b',
    'topology',
    'scenario',
    'k_eval',
    'metric',
    'matched_n',
    'effect_mean',
    'ci_low',
    'ci_high',
    'p_value',
    'a_better_rate',
]

RANKED_COLUMNS = [
    'method',
    'cells_n',
    'rac_mean',
    'lrc_mean',
    'ast_req_mean',
    'time_req_p95',
    'timeout_rate',
    'training_cost',
    'rank_rac',
    'rank_lrc',
    'rank_ast_req',
    'rank_time_req_p95',
    'rank_timeout_rate',
    'rank_training_cost',
    'composite_rank',
]


@dataclass(frozen=True)
class RunContext:
    """Metadata parsed from a run_id."""

    stage: Optional[str]
    topology: Optional[str]
    scenario: Optional[str]
    seed: Optional[int]
    k_train: Optional[int]
    k_eval: Optional[int]


def _as_str(value: Any) -> str:
    if value is None:
        return ''
    if isinstance(value, str):
        return value.strip()
    if pd.isna(value):
        return ''
    return str(value).strip()


def _to_float(value: Any, default: float = float('nan')) -> float:
    if value is None:
        return default
    try:
        if pd.isna(value):
            return default
    except TypeError:
        pass
    try:
        return float(value)
    except (TypeError, ValueError):
        return default


def _to_int_optional(value: Any) -> Optional[int]:
    if value is None:
        return None
    try:
        if pd.isna(value):
            return None
    except TypeError:
        pass
    try:
        return int(float(value))
    except (TypeError, ValueError):
        return None


def _safe_div(num: float, den: float, default: float = float('nan')) -> float:
    if den == 0 or math.isnan(den):
        return default
    if math.isnan(num):
        return default
    return num / den


def _first_existing(columns: Iterable[str], candidates: Sequence[str]) -> Optional[str]:
    available = set(str(col) for col in columns)
    for candidate in candidates:
        if candidate in available:
            return candidate
    return None


def _to_bool_series(series: pd.Series) -> pd.Series:
    numeric = pd.to_numeric(series, errors='coerce')
    if numeric.notna().any():
        return numeric.fillna(0).astype(float) != 0.0
    lowered = series.fillna('').astype(str).str.strip().str.lower()
    return lowered.isin({'1', 'true', 't', 'yes', 'y', 'on'})


def _quantile_from_series(series: pd.Series, q: float) -> float:
    values = pd.to_numeric(series, errors='coerce').dropna()
    if values.empty:
        return float('nan')
    return float(values.quantile(q))


def _nanstd(series: pd.Series) -> float:
    values = pd.to_numeric(series, errors='coerce').dropna().to_numpy(dtype=float)
    if values.size == 0:
        return float('nan')
    return float(values.std(ddof=0))


def _safe_ratio_series(num: pd.Series, den: pd.Series) -> pd.Series:
    ratio = pd.to_numeric(num, errors='coerce') / pd.to_numeric(den, errors='coerce')
    return ratio.replace([np.inf, -np.inf], np.nan)


def _rank_with_nan(series: pd.Series, ascending: bool) -> pd.Series:
    ranked = series.rank(ascending=ascending, method='dense')
    if ranked.isna().any():
        max_rank = ranked.max(skipna=True)
        fill_value = float(max_rank + 1 if pd.notna(max_rank) else 1.0)
        ranked = ranked.fillna(fill_value)
    return ranked.astype(float)


def parse_run_context(run_id: str) -> RunContext:
    """
    Parse metadata from run_id produced by tools/journal_experiments.py.

    Expected shape:
      <suite>__<solver>__<topology>__<scenario>__seed<seed>__train__ktrain<k>
      <suite>__<solver>__<topology>__<scenario>__seed<seed>__eval__keval<k>__...
    """
    parts = run_id.split('__')
    if len(parts) < 7:
        return RunContext(None, None, None, None, None, None)

    topology = parts[2] or None
    scenario = parts[3] or None

    seed = None
    seed_part = parts[4]
    if seed_part.startswith('seed'):
        seed = _to_int_optional(seed_part[len('seed') :])

    stage = parts[5] if parts[5] in {'train', 'eval'} else None
    k_train = None
    k_eval = None
    k_part = parts[6]
    if k_part.startswith('ktrain'):
        k_train = _to_int_optional(k_part[len('ktrain') :])
    elif k_part.startswith('keval'):
        k_eval = _to_int_optional(k_part[len('keval') :])

    return RunContext(
        stage=stage,
        topology=topology,
        scenario=scenario,
        seed=seed,
        k_train=k_train,
        k_eval=k_eval,
    )


def discover_summary_rows(results_root: Path) -> pd.DataFrame:
    """Load and stack all summary.csv files found under results_root."""
    frames: list[pd.DataFrame] = []
    for summary_path in sorted(results_root.rglob('summary.csv')):
        try:
            frame = pd.read_csv(summary_path)
        except Exception:
            continue
        if frame.empty:
            continue
        frame = frame.copy()
        frame['__summary_path'] = str(summary_path)
        frame['__records_dir'] = str(summary_path.parent / 'records')
        frame['__row_idx'] = np.arange(len(frame), dtype=int)
        frames.append(frame)
    if not frames:
        return pd.DataFrame()
    return pd.concat(frames, ignore_index=True)


def _select_record_files(
    records_dir: Path,
    run_id: str,
    start_run_time: str,
    seed: Optional[int],
) -> list[Path]:
    files = sorted(
        path
        for path in records_dir.glob('*.csv')
        if path.is_file() and not path.name.startswith('temp-')
    )
    if not files:
        return []

    selected = files
    if start_run_time:
        by_start = [path for path in selected if start_run_time in path.name]
        if by_start:
            selected = by_start
    if seed is not None:
        by_seed = [path for path in selected if f'seed{seed}' in path.name]
        if by_seed:
            selected = by_seed
    if run_id:
        by_run_id = [path for path in selected if run_id in path.name]
        if by_run_id:
            selected = by_run_id
    return selected


def load_records_for_summary_row(row: pd.Series, run_id: str, seed: Optional[int]) -> pd.DataFrame:
    """Load record CSV files that most likely correspond to a summary row."""
    records_dir = Path(_as_str(row.get('__records_dir')))
    if not records_dir.exists() or not records_dir.is_dir():
        return pd.DataFrame()

    start_run_time = _as_str(row.get('start_run_time'))
    selected_files = _select_record_files(
        records_dir=records_dir,
        run_id=run_id,
        start_run_time=start_run_time,
        seed=seed,
    )
    if not selected_files:
        return pd.DataFrame()

    frames: list[pd.DataFrame] = []
    for csv_path in selected_files:
        try:
            frame = pd.read_csv(csv_path)
        except Exception:
            continue
        if frame.empty:
            continue
        frame = frame.copy()
        frame['__record_path'] = str(csv_path)
        frames.append(frame)
    if not frames:
        return pd.DataFrame()
    return pd.concat(frames, ignore_index=True)


def _arrival_count_from_summary(row: pd.Series) -> int:
    for col in ARRIVAL_COUNT_COLUMNS:
        if col in row:
            value = _to_int_optional(row[col])
            if value is not None and value > 0:
                return value

    total = 0.0
    found_any = False
    for col in ('success_count', 'early_rejection_count', 'place_failure_count', 'route_failure_count'):
        if col not in row:
            continue
        value = _to_float(row[col], default=float('nan'))
        if math.isnan(value):
            continue
        found_any = True
        total += max(value, 0.0)
    if found_any and total > 0:
        return int(round(total))
    return 0


def _summary_timeout_count(row: pd.Series) -> Optional[int]:
    for col in TIMEOUT_COUNT_COLUMNS:
        if col not in row:
            continue
        value = _to_float(row[col], default=float('nan'))
        if math.isnan(value):
            continue
        return max(int(round(value)), 0)
    return None


def _summary_run_timeout_flag(row: pd.Series) -> bool:
    for col in RUN_TIMEOUT_COLUMNS:
        if col not in row:
            continue
        value = row[col]
        if pd.isna(value):
            continue
        return bool(_to_bool_series(pd.Series([value])).iloc[0])
    return False


def _record_metrics(records: pd.DataFrame) -> tuple[int, float, float, float, Optional[float]]:
    if records.empty:
        return 0, float('nan'), float('nan'), float('nan'), None

    arrivals = records
    if 'event_type' in records.columns:
        event_type = pd.to_numeric(records['event_type'], errors='coerce')
        filtered = records.loc[event_type == 1].copy()
        if not filtered.empty:
            arrivals = filtered
    num_arrivals = int(len(arrivals))

    time_mean = float('nan')
    time_median = float('nan')
    time_p95 = float('nan')
    runtime_col = _first_existing(arrivals.columns, RUNTIME_COLUMNS)
    if runtime_col is not None:
        runtimes = pd.to_numeric(arrivals[runtime_col], errors='coerce').fillna(0.0)
        if not runtimes.empty:
            time_mean = float(runtimes.mean())
            time_median = float(runtimes.median())
            time_p95 = _quantile_from_series(runtimes, 0.95)

    timeout_rate = None
    timeout_col = _first_existing(arrivals.columns, TIMEOUT_COLUMNS)
    if timeout_col is not None and num_arrivals > 0:
        timeout_flags = _to_bool_series(arrivals[timeout_col])
        timeout_rate = float(timeout_flags.mean())

    return num_arrivals, time_mean, time_median, time_p95, timeout_rate


def build_run_metrics(summary_rows: pd.DataFrame) -> pd.DataFrame:
    """Build a run-level metric table by combining summary rows + record files."""
    run_rows: list[dict[str, Any]] = []

    for _, row in summary_rows.iterrows():
        summary_path = Path(_as_str(row.get('__summary_path')))
        run_id = _as_str(row.get('run_id')) or summary_path.parent.name
        if not run_id:
            continue

        context = parse_run_context(run_id)
        stage = context.stage
        if stage is None:
            if '__train__' in run_id:
                stage = 'train'
            elif '__eval__' in run_id:
                stage = 'eval'
            else:
                continue

        method = _as_str(row.get('solver_name'))
        if not method:
            method = summary_path.parent.parent.name if summary_path.parent.parent else ''

        topology = context.topology or _as_str(row.get('topology')) or 'unknown'
        scenario = context.scenario or _as_str(row.get('scenario')) or 'unknown'

        seed = _to_int_optional(row.get('seed'))
        if seed is None:
            seed = context.seed

        ast_run = _to_float(row.get('clock_running_time'), default=float('nan'))
        rac = _to_float(row.get('acceptance_rate'), default=float('nan'))
        lrc = _to_float(row.get('long_term_r2c_ratio'), default=float('nan'))
        if math.isnan(lrc):
            lrc = _to_float(row.get('avg_r2c_ratio'), default=float('nan'))

        records = load_records_for_summary_row(row=row, run_id=run_id, seed=seed)
        arrivals_from_records, time_mean, time_median, time_p95, timeout_rate = _record_metrics(records)
        arrivals = arrivals_from_records if arrivals_from_records > 0 else _arrival_count_from_summary(row)
        ast_req = _safe_div(ast_run, float(arrivals), default=float('nan')) if arrivals > 0 else float('nan')

        if math.isnan(time_mean):
            time_mean = ast_req
        if math.isnan(time_median):
            time_median = ast_req
        if math.isnan(time_p95):
            time_p95 = ast_req

        if timeout_rate is None:
            timeout_count = _summary_timeout_count(row)
            if timeout_count is not None and arrivals > 0:
                timeout_rate = _safe_div(float(timeout_count), float(arrivals), default=0.0)
            else:
                timeout_rate = 0.0

        start_run_time = _as_str(row.get('start_run_time'))
        run_key = f'{run_id}::{start_run_time}::{_as_str(row.get("__row_idx"))}'

        run_rows.append(
            {
                'method': method,
                'run_id': run_id,
                'run_key': run_key,
                'summary_path': str(summary_path),
                'start_run_time': start_run_time,
                'stage': stage,
                'topology': topology,
                'scenario': scenario,
                'seed': seed,
                'k_train': context.k_train,
                'k_eval': context.k_eval,
                'rac': rac,
                'lrc': lrc,
                'ast_run': ast_run,
                'num_arrivals': arrivals,
                'ast_req': ast_req,
                'time_req_mean': time_mean,
                'time_req_median': time_median,
                'time_req_p95': time_p95,
                'timeout_rate': timeout_rate,
                'run_timeout': _summary_run_timeout_flag(row),
            }
        )

    if not run_rows:
        return pd.DataFrame(
            columns=[
                'method',
                'run_id',
                'run_key',
                'summary_path',
                'start_run_time',
                'stage',
                'topology',
                'scenario',
                'seed',
                'k_train',
                'k_eval',
                'rac',
                'lrc',
                'ast_run',
                'num_arrivals',
                'ast_req',
                'time_req_mean',
                'time_req_median',
                'time_req_p95',
                'timeout_rate',
                'run_timeout',
            ]
        )

    return pd.DataFrame(run_rows)


def select_latest_runs_per_cell(run_metrics: pd.DataFrame) -> pd.DataFrame:
    """Keep only the latest run for each train/eval experiment cell."""
    if run_metrics.empty:
        return run_metrics.copy()

    filtered = run_metrics.copy()
    filtered['start_run_dt'] = pd.to_datetime(
        filtered['start_run_time'],
        format='%Y%m%dT%H%M%S',
        errors='coerce',
    )

    stage_groups = {
        'train': ['method', 'topology', 'scenario', 'seed', 'k_train'],
        'eval': ['method', 'topology', 'scenario', 'seed', 'k_eval'],
    }

    keep_frames: list[pd.DataFrame] = []
    for stage, group_cols in stage_groups.items():
        stage_rows = filtered[filtered['stage'] == stage].copy()
        if stage_rows.empty:
            continue
        stage_rows = stage_rows.sort_values(
            ['start_run_dt', 'start_run_time', 'run_id', 'summary_path', 'run_key'],
            na_position='first',
        )
        keep_frames.append(stage_rows.groupby(group_cols, dropna=False).tail(1))

    other_rows = filtered[~filtered['stage'].isin(stage_groups)].copy()
    if not other_rows.empty:
        keep_frames.append(other_rows)

    if not keep_frames:
        return filtered.iloc[0:0].drop(columns=['start_run_dt'], errors='ignore')

    deduped = pd.concat(keep_frames, ignore_index=True)
    deduped = deduped.sort_values(
        ['stage', 'method', 'topology', 'scenario', 'seed', 'k_train', 'k_eval', 'start_run_dt', 'run_id'],
        na_position='first',
    ).reset_index(drop=True)
    return deduped.drop(columns=['start_run_dt'], errors='ignore')


def attach_training_cost(eval_runs: pd.DataFrame, train_runs: pd.DataFrame) -> pd.DataFrame:
    """Attach per-eval-row training wall-clock cost from matching train rows."""
    result = eval_runs.copy()
    if result.empty:
        result['training_cost'] = []
        return result

    result['training_cost'] = 0.0
    if train_runs.empty:
        return result

    by_seed = (
        train_runs.groupby(['method', 'topology', 'scenario', 'seed'], dropna=False)['ast_run']
        .mean()
        .to_dict()
    )
    by_cell = (
        train_runs.groupby(['method', 'topology', 'scenario'], dropna=False)['ast_run']
        .mean()
        .to_dict()
    )

    costs: list[float] = []
    for _, row in result.iterrows():
        key_seed = (row['method'], row['topology'], row['scenario'], row['seed'])
        key_cell = (row['method'], row['topology'], row['scenario'])
        cost = by_seed.get(key_seed)
        if cost is None:
            cost = by_cell.get(key_cell, 0.0)
        costs.append(float(cost) if cost is not None and not math.isnan(float(cost)) else 0.0)
    result['training_cost'] = costs
    return result


def build_main_metrics(eval_runs: pd.DataFrame) -> pd.DataFrame:
    if eval_runs.empty:
        return pd.DataFrame(columns=MAIN_COLUMNS)

    grouped = eval_runs.groupby(['method', 'topology', 'scenario', 'k_eval'], dropna=False)
    table = (
        grouped.agg(
            seeds_n=('seed', 'nunique'),
            runs_n=('run_key', 'nunique'),
            rac_mean=('rac', 'mean'),
            rac_std=('rac', _nanstd),
            lrc_mean=('lrc', 'mean'),
            lrc_std=('lrc', _nanstd),
            ast_run_mean=('ast_run', 'mean'),
            ast_req_mean=('ast_req', 'mean'),
            time_req_mean=('time_req_mean', 'mean'),
            time_req_median=('time_req_median', 'mean'),
            time_req_p95=('time_req_p95', 'mean'),
            timeout_rate=('timeout_rate', 'mean'),
            training_cost=('training_cost', 'mean'),
        )
        .reset_index()
        .sort_values(['method', 'topology', 'scenario', 'k_eval'])
        .reset_index(drop=True)
    )
    return table[MAIN_COLUMNS]


def build_runtime_metrics(eval_runs: pd.DataFrame) -> pd.DataFrame:
    if eval_runs.empty:
        return pd.DataFrame(columns=RUNTIME_COLUMNS_OUT)

    grouped = eval_runs.groupby(['method', 'topology', 'scenario', 'k_eval'], dropna=False)
    table = (
        grouped.agg(
            seeds_n=('seed', 'nunique'),
            runs_n=('run_key', 'nunique'),
            ast_run_mean=('ast_run', 'mean'),
            ast_run_p95=('ast_run', lambda s: _quantile_from_series(s, 0.95)),
            ast_req_mean=('ast_req', 'mean'),
            ast_req_p95=('ast_req', lambda s: _quantile_from_series(s, 0.95)),
            time_req_mean=('time_req_mean', 'mean'),
            time_req_median=('time_req_median', 'mean'),
            time_req_p95=('time_req_p95', 'mean'),
            timeout_rate=('timeout_rate', 'mean'),
            timeout_rate_p95=('timeout_rate', lambda s: _quantile_from_series(s, 0.95)),
            training_cost=('training_cost', 'mean'),
        )
        .reset_index()
        .sort_values(['method', 'topology', 'scenario', 'k_eval'])
        .reset_index(drop=True)
    )
    return table[RUNTIME_COLUMNS_OUT]


def build_k_ablation(main_metrics: pd.DataFrame) -> pd.DataFrame:
    if main_metrics.empty:
        return pd.DataFrame(columns=K_ABLATION_COLUMNS)

    rows: list[dict[str, Any]] = []
    grouped = main_metrics.groupby(['method', 'topology', 'scenario'], dropna=False)
    for (method, topology, scenario), group in grouped:
        group = group.sort_values('k_eval')
        baseline = group[group['k_eval'] == 10]
        if not baseline.empty:
            baseline_row = baseline.iloc[0]
        else:
            valid_k = pd.to_numeric(group['k_eval'], errors='coerce')
            if valid_k.notna().any():
                nearest_idx = (valid_k - 10).abs().idxmin()
                baseline_row = group.loc[nearest_idx]
            else:
                baseline_row = group.iloc[0]

        for _, row in group.iterrows():
            rows.append(
                {
                    'method': method,
                    'topology': topology,
                    'scenario': scenario,
                    'k_eval': row['k_eval'],
                    'seeds_n': row['seeds_n'],
                    'rac_mean': row['rac_mean'],
                    'lrc_mean': row['lrc_mean'],
                    'ast_req_mean': row['ast_req_mean'],
                    'time_req_p95': row['time_req_p95'],
                    'timeout_rate': row['timeout_rate'],
                    'training_cost': row['training_cost'],
                    'baseline_k': baseline_row['k_eval'],
                    'delta_rac_vs_baseline': row['rac_mean'] - baseline_row['rac_mean'],
                    'delta_lrc_vs_baseline': row['lrc_mean'] - baseline_row['lrc_mean'],
                    'speedup_ast_req_vs_baseline': _safe_div(
                        baseline_row['ast_req_mean'],
                        row['ast_req_mean'],
                        default=float('nan'),
                    ),
                    'speedup_time_req_p95_vs_baseline': _safe_div(
                        baseline_row['time_req_p95'],
                        row['time_req_p95'],
                        default=float('nan'),
                    ),
                }
            )

    return pd.DataFrame(rows)[K_ABLATION_COLUMNS].sort_values(
        ['method', 'topology', 'scenario', 'k_eval']
    )


def _bootstrap_mean_ci(
    values: np.ndarray,
    confidence_level: float,
    samples: int,
) -> tuple[float, float]:
    if values.size == 0:
        return float('nan'), float('nan')
    if values.size == 1:
        v = float(values[0])
        return v, v

    alpha = 1.0 - confidence_level
    rng = np.random.default_rng(0)
    index = rng.integers(0, values.size, size=(samples, values.size))
    boot_means = values[index].mean(axis=1)
    low = float(np.quantile(boot_means, alpha / 2.0))
    high = float(np.quantile(boot_means, 1.0 - alpha / 2.0))
    return low, high


def _wilcoxon_p_value(values: np.ndarray) -> float:
    if values.size < 2 or wilcoxon is None:
        return float('nan')
    if np.allclose(values, values[0]):
        return 1.0
    try:
        return float(wilcoxon(values, alternative='two-sided', zero_method='wilcox').pvalue)
    except Exception:
        return float('nan')


def _metric_significance(
    values: pd.Series,
    confidence_level: float,
    bootstrap_samples: int,
) -> tuple[int, float, float, float, float, float]:
    arr = pd.to_numeric(values, errors='coerce').replace([np.inf, -np.inf], np.nan).dropna()
    if arr.empty:
        return 0, float('nan'), float('nan'), float('nan'), float('nan'), float('nan')

    raw = arr.to_numpy(dtype=float)
    effect = float(raw.mean())
    ci_low, ci_high = _bootstrap_mean_ci(
        values=raw,
        confidence_level=confidence_level,
        samples=bootstrap_samples,
    )
    p_value = _wilcoxon_p_value(raw)
    better_rate = float((raw > 0).mean())
    return int(raw.size), effect, ci_low, ci_high, p_value, better_rate


def build_pairwise_and_significance(
    eval_runs: pd.DataFrame,
    confidence_level: float,
    bootstrap_samples: int,
) -> tuple[pd.DataFrame, pd.DataFrame]:
    if eval_runs.empty:
        return (
            pd.DataFrame(columns=PAIRWISE_COLUMNS),
            pd.DataFrame(columns=SIGNIFICANCE_COLUMNS),
        )

    seed_level = (
        eval_runs.groupby(['method', 'topology', 'scenario', 'k_eval', 'seed'], dropna=False)
        .agg(
            rac=('rac', 'mean'),
            lrc=('lrc', 'mean'),
            ast_req=('ast_req', 'mean'),
            time_req_p95=('time_req_p95', 'mean'),
        )
        .reset_index()
    )

    pairwise_rows: list[dict[str, Any]] = []
    significance_rows: list[dict[str, Any]] = []

    for (topology, scenario, k_eval), cell in seed_level.groupby(
        ['topology', 'scenario', 'k_eval'],
        dropna=False,
    ):
        methods = sorted(cell['method'].dropna().unique().tolist())
        for method_a, method_b in itertools.combinations(methods, 2):
            left = cell[cell['method'] == method_a][['seed', 'rac', 'lrc', 'ast_req', 'time_req_p95']]
            right = cell[cell['method'] == method_b][['seed', 'rac', 'lrc', 'ast_req', 'time_req_p95']]
            merged = left.merge(right, on='seed', suffixes=('_a', '_b'))
            if merged.empty:
                continue

            delta_rac = merged['rac_a'] - merged['rac_b']
            delta_lrc = merged['lrc_a'] - merged['lrc_b']
            speedup_ast = _safe_ratio_series(merged['ast_req_b'], merged['ast_req_a'])
            speedup_p95 = _safe_ratio_series(merged['time_req_p95_b'], merged['time_req_p95_a'])

            pairwise_rows.append(
                {
                    'method_a': method_a,
                    'method_b': method_b,
                    'topology': topology,
                    'scenario': scenario,
                    'k_eval': k_eval,
                    'matched_n': int(len(merged)),
                    'delta_rac_mean': float(delta_rac.mean()),
                    'delta_lrc_mean': float(delta_lrc.mean()),
                    'speedup_ast_req_mean': float(speedup_ast.mean()),
                    'speedup_time_req_p95_mean': float(speedup_p95.mean()),
                    'win_rate': float(((delta_rac > 0).sum() + 0.5 * (delta_rac == 0).sum()) / len(delta_rac)),
                }
            )

            significance_specs = [
                ('rac', delta_rac),
                ('lrc', delta_lrc),
                ('ast_req_speedup', np.log(speedup_ast.where(speedup_ast > 0))),
                ('time_req_p95_speedup', np.log(speedup_p95.where(speedup_p95 > 0))),
            ]
            for metric_name, values in significance_specs:
                matched_n, effect, ci_low, ci_high, p_value, better_rate = _metric_significance(
                    values=values,
                    confidence_level=confidence_level,
                    bootstrap_samples=bootstrap_samples,
                )
                significance_rows.append(
                    {
                        'method_a': method_a,
                        'method_b': method_b,
                        'topology': topology,
                        'scenario': scenario,
                        'k_eval': k_eval,
                        'metric': metric_name,
                        'matched_n': matched_n,
                        'effect_mean': effect,
                        'ci_low': ci_low,
                        'ci_high': ci_high,
                        'p_value': p_value,
                        'a_better_rate': better_rate,
                    }
                )

    pairwise = pd.DataFrame(pairwise_rows, columns=PAIRWISE_COLUMNS)
    if not pairwise.empty:
        pairwise = pairwise.sort_values(['method_a', 'method_b', 'topology', 'scenario', 'k_eval'])

    significance = pd.DataFrame(significance_rows, columns=SIGNIFICANCE_COLUMNS)
    if not significance.empty:
        significance = significance.sort_values(
            ['method_a', 'method_b', 'topology', 'scenario', 'k_eval', 'metric']
        )
    return pairwise, significance


def build_ranked_summary(main_metrics: pd.DataFrame) -> pd.DataFrame:
    if main_metrics.empty:
        return pd.DataFrame(columns=RANKED_COLUMNS)

    ranked = (
        main_metrics.groupby(['method'], dropna=False)
        .agg(
            cells_n=('k_eval', 'count'),
            rac_mean=('rac_mean', 'mean'),
            lrc_mean=('lrc_mean', 'mean'),
            ast_req_mean=('ast_req_mean', 'mean'),
            time_req_p95=('time_req_p95', 'mean'),
            timeout_rate=('timeout_rate', 'mean'),
            training_cost=('training_cost', 'mean'),
        )
        .reset_index()
    )

    ranked['rank_rac'] = _rank_with_nan(ranked['rac_mean'], ascending=False)
    ranked['rank_lrc'] = _rank_with_nan(ranked['lrc_mean'], ascending=False)
    ranked['rank_ast_req'] = _rank_with_nan(ranked['ast_req_mean'], ascending=True)
    ranked['rank_time_req_p95'] = _rank_with_nan(ranked['time_req_p95'], ascending=True)
    ranked['rank_timeout_rate'] = _rank_with_nan(ranked['timeout_rate'], ascending=True)
    ranked['rank_training_cost'] = _rank_with_nan(ranked['training_cost'], ascending=True)
    ranked['composite_rank'] = ranked[
        [
            'rank_rac',
            'rank_lrc',
            'rank_ast_req',
            'rank_time_req_p95',
            'rank_timeout_rate',
            'rank_training_cost',
        ]
    ].mean(axis=1)

    ranked = ranked.sort_values(['composite_rank', 'method']).reset_index(drop=True)
    return ranked[RANKED_COLUMNS]


def aggregate(
    suite_root: Path,
    results_root: Optional[Path],
    tables_dir: Optional[Path],
    confidence_level: float,
    bootstrap_samples: int,
    latest_per_cell: bool,
) -> dict[str, pd.DataFrame]:
    resolved_results_root = results_root if results_root is not None else suite_root / 'results'
    resolved_tables_dir = tables_dir if tables_dir is not None else suite_root / 'tables'

    summary_rows = discover_summary_rows(resolved_results_root)
    if summary_rows.empty:
        raise FileNotFoundError(f'No summary.csv files found under {resolved_results_root}')

    run_metrics = build_run_metrics(summary_rows)
    if latest_per_cell:
        run_metrics = select_latest_runs_per_cell(run_metrics)
    train_runs = run_metrics[run_metrics['stage'] == 'train'].copy()
    eval_runs = run_metrics[run_metrics['stage'] == 'eval'].copy()
    eval_runs = attach_training_cost(eval_runs=eval_runs, train_runs=train_runs)

    main_metrics = build_main_metrics(eval_runs)
    runtime_metrics = build_runtime_metrics(eval_runs)
    k_ablation = build_k_ablation(main_metrics)
    pairwise, significance = build_pairwise_and_significance(
        eval_runs=eval_runs,
        confidence_level=confidence_level,
        bootstrap_samples=bootstrap_samples,
    )
    ranked = build_ranked_summary(main_metrics)

    resolved_tables_dir.mkdir(parents=True, exist_ok=True)
    tables = {
        'main_metrics.csv': main_metrics,
        'runtime_metrics.csv': runtime_metrics,
        'k_ablation.csv': k_ablation,
        'pairwise_deltas.csv': pairwise,
        'significance.csv': significance,
        'ranked_summary.csv': ranked,
    }
    for filename, table in tables.items():
        output_path = resolved_tables_dir / filename
        table.to_csv(output_path, index=False)
        print(f'[aggregate] wrote {output_path} ({len(table)} rows)')

    print(f'[aggregate] summary_rows={len(summary_rows)} train_rows={len(train_runs)} eval_rows={len(eval_runs)}')
    return tables


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description='Aggregate journal experiment outputs.')
    parser.add_argument(
        '--suite-root',
        default='results/journal_suite',
        help='Journal suite root directory.',
    )
    parser.add_argument(
        '--results-root',
        default=None,
        help='Optional results root. Defaults to <suite_root>/results.',
    )
    parser.add_argument(
        '--tables-dir',
        default=None,
        help='Optional tables output dir. Defaults to <suite_root>/tables.',
    )
    parser.add_argument(
        '--confidence-level',
        type=float,
        default=0.95,
        help='Confidence level for bootstrap intervals in significance table.',
    )
    parser.add_argument(
        '--bootstrap-samples',
        type=int,
        default=2000,
        help='Number of bootstrap resamples for significance intervals.',
    )
    parser.add_argument(
        '--latest-per-cell',
        action='store_true',
        help='Keep only the latest train/eval run per (method, topology, scenario, seed, k) cell.',
    )
    return parser


def main(argv: Optional[Sequence[str]] = None) -> int:
    args = build_parser().parse_args(argv)
    suite_root = Path(args.suite_root).resolve()
    results_root = Path(args.results_root).resolve() if args.results_root else None
    tables_dir = Path(args.tables_dir).resolve() if args.tables_dir else None

    aggregate(
        suite_root=suite_root,
        results_root=results_root,
        tables_dir=tables_dir,
        confidence_level=float(args.confidence_level),
        bootstrap_samples=int(args.bootstrap_samples),
        latest_per_cell=bool(args.latest_per_cell),
    )
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
