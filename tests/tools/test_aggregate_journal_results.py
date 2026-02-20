import subprocess
import sys
from pathlib import Path

import pandas as pd


REPO_ROOT = Path(__file__).resolve().parents[2]
AGGREGATOR = REPO_ROOT / 'tools' / 'aggregate_journal_results.py'


def _write_run(
    results_root: Path,
    solver_name: str,
    run_id: str,
    summary_row: dict,
    record_rows: list[dict] | None = None,
) -> None:
    run_dir = results_root / solver_name / run_id
    run_dir.mkdir(parents=True, exist_ok=True)

    summary_path = run_dir / 'summary.csv'
    pd.DataFrame([summary_row]).to_csv(summary_path, index=False)

    if record_rows is not None:
        records_dir = run_dir / 'records'
        records_dir.mkdir(parents=True, exist_ok=True)
        start_run_time = summary_row.get('start_run_time', '20260101T000000')
        seed = int(summary_row.get('seed', 0))
        record_name = f'{solver_name}-{run_id}-{start_run_time}-seed{seed}.csv'
        pd.DataFrame(record_rows).to_csv(records_dir / record_name, index=False)


def _run_aggregator(suite_root: Path) -> None:
    subprocess.run(
        [
            sys.executable,
            str(AGGREGATOR),
            '--suite-root',
            str(suite_root),
            '--bootstrap-samples',
            '200',
        ],
        check=True,
        cwd=str(REPO_ROOT),
    )


def test_aggregate_journal_results_generates_expected_tables(tmp_path: Path) -> None:
    suite_root = tmp_path / 'journal_suite'
    results_root = suite_root / 'results'

    for seed, train_time in ((0, 100.0), (1, 120.0)):
        train_run_id = (
            f'journal_suite__alpha_zero_sfc__wx100__nominal__seed{seed}__train__ktrain10'
        )
        _write_run(
            results_root=results_root,
            solver_name='alpha_zero_sfc',
            run_id=train_run_id,
            summary_row={
                'solver_name': 'alpha_zero_sfc',
                'seed': seed,
                'run_id': train_run_id,
                'acceptance_rate': 0.0,
                'long_term_r2c_ratio': 0.0,
                'clock_running_time': train_time,
                'success_count': 0,
                'early_rejection_count': 0,
                'place_failure_count': 0,
                'route_failure_count': 0,
                'start_run_time': f'20260101T00010{seed}',
            },
            record_rows=[
                {'event_type': 1},
                {'event_type': 0},
            ],
        )

    eval_specs = [
        ('alpha_zero_sfc', 0, 5, 0.70, 1.20, 7.0, [1.0, 2.0, 3.0], [0, 1, 0]),
        ('alpha_zero_sfc', 1, 5, 0.80, 1.30, 6.0, [1.0, 1.0, 2.0], [0, 0, 0]),
        ('alpha_zero_sfc', 0, 10, 0.75, 1.25, 6.5, [1.5, 1.5, 1.5], [0, 0, 0]),
        ('alpha_zero_sfc', 1, 10, 0.78, 1.28, 6.2, [1.2, 1.3, 1.1], [0, 0, 0]),
        ('mcts', 0, 5, 0.50, 1.00, 5.0, [2.0, 2.0, 2.0], [0, 0, 0]),
        ('mcts', 1, 5, 0.60, 1.10, 5.5, [2.0, 2.0, 3.0], [0, 0, 0]),
        ('mcts', 0, 10, 0.52, 1.02, 5.1, [2.1, 2.0, 2.2], [0, 0, 0]),
        ('mcts', 1, 10, 0.61, 1.12, 5.4, [2.0, 2.1, 2.1], [0, 0, 0]),
    ]

    for solver_name, seed, k_eval, rac, lrc, runtime, solve_times, timeout_flags in eval_specs:
        run_id = f'journal_suite__{solver_name}__wx100__nominal__seed{seed}__eval__keval{k_eval}__ckptlatest'
        records = []
        for idx in range(3):
            records.append(
                {
                    'event_type': 1,
                    'solve_time_sec': solve_times[idx],
                    'request_timeout': timeout_flags[idx],
                }
            )
            records.append({'event_type': 0})

        _write_run(
            results_root=results_root,
            solver_name=solver_name,
            run_id=run_id,
            summary_row={
                'solver_name': solver_name,
                'seed': seed,
                'run_id': run_id,
                'acceptance_rate': rac,
                'long_term_r2c_ratio': lrc,
                'clock_running_time': runtime,
                'success_count': 2,
                'early_rejection_count': 0,
                'place_failure_count': 1,
                'route_failure_count': 0,
                'start_run_time': f'20260102T000{seed}{k_eval}',
            },
            record_rows=records,
        )

    _run_aggregator(suite_root=suite_root)

    tables_dir = suite_root / 'tables'
    expected_files = {
        'main_metrics.csv',
        'runtime_metrics.csv',
        'k_ablation.csv',
        'pairwise_deltas.csv',
        'significance.csv',
        'ranked_summary.csv',
    }
    for filename in expected_files:
        assert (tables_dir / filename).exists(), f'missing output table: {filename}'

    main_metrics = pd.read_csv(tables_dir / 'main_metrics.csv')
    alpha_k5 = main_metrics[
        (main_metrics['method'] == 'alpha_zero_sfc') & (main_metrics['k_eval'] == 5)
    ].iloc[0]
    assert alpha_k5['seeds_n'] == 2
    assert abs(alpha_k5['rac_mean'] - 0.75) < 1e-9
    assert abs(alpha_k5['lrc_mean'] - 1.25) < 1e-9
    assert abs(alpha_k5['training_cost'] - 110.0) < 1e-9

    pairwise = pd.read_csv(tables_dir / 'pairwise_deltas.csv')
    pair_row = pairwise[
        (pairwise['method_a'] == 'alpha_zero_sfc')
        & (pairwise['method_b'] == 'mcts')
        & (pairwise['k_eval'] == 5)
    ].iloc[0]
    assert pair_row['matched_n'] == 2
    assert abs(pair_row['delta_rac_mean'] - 0.2) < 1e-9

    significance = pd.read_csv(tables_dir / 'significance.csv')
    sig_row = significance[
        (significance['method_a'] == 'alpha_zero_sfc')
        & (significance['method_b'] == 'mcts')
        & (significance['k_eval'] == 5)
        & (significance['metric'] == 'rac')
    ].iloc[0]
    assert sig_row['matched_n'] == 2


def test_runtime_falls_back_to_ast_req_when_record_runtime_missing(tmp_path: Path) -> None:
    suite_root = tmp_path / 'journal_suite'
    results_root = suite_root / 'results'

    run_id = 'journal_suite__mcts__wx100__nominal__seed0__eval__keval5__ckptlatest'
    _write_run(
        results_root=results_root,
        solver_name='mcts',
        run_id=run_id,
        summary_row={
            'solver_name': 'mcts',
            'seed': 0,
            'run_id': run_id,
            'acceptance_rate': 0.5,
            'long_term_r2c_ratio': 1.0,
            'clock_running_time': 8.0,
            'success_count': 2,
            'early_rejection_count': 1,
            'place_failure_count': 1,
            'route_failure_count': 0,
            'start_run_time': '20260103T000000',
        },
        record_rows=[
            {'event_type': 1},
            {'event_type': 0},
            {'event_type': 1},
            {'event_type': 0},
            {'event_type': 1},
            {'event_type': 0},
            {'event_type': 1},
            {'event_type': 0},
        ],
    )

    _run_aggregator(suite_root=suite_root)

    runtime_metrics = pd.read_csv(suite_root / 'tables' / 'runtime_metrics.csv')
    row = runtime_metrics[(runtime_metrics['method'] == 'mcts') & (runtime_metrics['k_eval'] == 5)].iloc[0]
    assert abs(row['ast_req_mean'] - 2.0) < 1e-9
    assert abs(row['time_req_mean'] - 2.0) < 1e-9
    assert abs(row['time_req_p95'] - 2.0) < 1e-9
    assert abs(row['timeout_rate'] - 0.0) < 1e-9
