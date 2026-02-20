#!/usr/bin/env python3
"""
Calculate average acceptance rates for AlphaZero k-sweep results.

This script analyzes the results from alpha_zero_sfc training runs,
extracting acceptance rates from CSV files in the records directory.
"""
import os
import csv
import re
from pathlib import Path
from collections import defaultdict


def extract_k_value(folder_name):
    """Extract k value from folder name like 'az_k_sweep-k01-...'"""
    match = re.search(r'k(\d+)', folder_name)
    if match:
        return int(match.group(1))
    return None


def get_acceptance_rate_from_csv(csv_path):
    """
    Read last row of CSV and calculate acceptance rate.
    First column: v_net_count (total)
    Second column: success_count (accepted)
    Returns: success_count / v_net_count
    """
    try:
        with open(csv_path, 'r') as f:
            reader = csv.reader(f)
            rows = list(reader)

            if len(rows) < 2:  # Need at least header + 1 data row
                return None

            last_row = rows[-1]

            if len(last_row) < 2:
                return None

            try:
                v_net_count = float(last_row[0])  # Total requests
                success_count = float(last_row[1])  # Accepted requests

                if v_net_count == 0:
                    return None

                return success_count / v_net_count  # Acceptance rate
            except (ValueError, IndexError):
                return None
    except Exception as e:
        print(f"Error reading {csv_path}: {e}")
        return None


def analyze_alpha_zero_results(results_dir):
    """
    Analyze all alpha_zero_sfc results and calculate acceptance rates per k.

    Args:
        results_dir: Path to results directory (e.g., 'results/alpha_zero_sfc')

    Returns:
        dict: {k_value: average_acceptance_rate}
    """
    results_path = Path(results_dir)

    if not results_path.exists():
        print(f"Results directory not found: {results_dir}")
        return {}

    # Collect acceptance rates per k value
    k_rates = defaultdict(list)

    # Iterate through all subdirectories
    for folder in results_path.iterdir():
        if not folder.is_dir():
            continue

        k_val = extract_k_value(folder.name)
        if k_val is None:
            continue

        # Look for records directory
        records_dir = folder / 'records'
        if not records_dir.exists():
            continue

        # Process all CSV files in records
        csv_files = list(records_dir.glob('*.csv'))

        for csv_file in csv_files:
            rate = get_acceptance_rate_from_csv(csv_file)
            if rate is not None:
                k_rates[k_val].append(rate)

    # Calculate averages
    k_averages = {}
    for k_val in sorted(k_rates.keys()):
        rates = k_rates[k_val]
        if rates:
            avg_rate = sum(rates) / len(rates)
            k_averages[k_val] = {
                'average': avg_rate,
                'count': len(rates),
                'rates': rates
            }

    return k_averages


def main():
    import argparse

    parser = argparse.ArgumentParser(
        description='Calculate average acceptance rates from AlphaZero k-sweep results'
    )
    parser.add_argument(
        '--results-dir',
        default='results/alpha_zero_sfc',
        help='Path to alpha_zero_sfc results directory'
    )
    parser.add_argument(
        '--verbose',
        action='store_true',
        help='Show individual CSV file rates'
    )

    args = parser.parse_args()

    print(f"Analyzing results in: {args.results_dir}")
    print("=" * 60)

    k_averages = analyze_alpha_zero_results(args.results_dir)

    if not k_averages:
        print("No results found!")
        return

    print(f"\n{'k':<5} {'Avg Acceptance Rate':<20} {'# CSVs':<10}")
    print("-" * 60)

    for k_val in sorted(k_averages.keys()):
        data = k_averages[k_val]
        print(f"{k_val:<5} {data['average']:.4f} ({data['average']*100:.2f}%)    {data['count']:<10}")

        if args.verbose:
            for i, rate in enumerate(data['rates']):
                print(f"      CSV {i+1}: {rate:.4f} ({rate*100:.2f}%)")

    print("=" * 60)

    # Find best k
    if k_averages:
        best_k = max(k_averages.items(), key=lambda x: x[1]['average'])
        print(f"\nBest k value: k={best_k[0]} with {best_k[1]['average']*100:.2f}% acceptance rate")


if __name__ == '__main__':
    main()
