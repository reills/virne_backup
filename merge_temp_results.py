#!/usr/bin/env python3
"""
Merge all temp_results_*.csv files into one consolidated results file
"""

import pandas as pd
import glob
from pathlib import Path

def merge_temp_results(experiment_dir):
    """Merge all temp CSV files in an experiment directory"""
    
    experiment_path = Path(experiment_dir)
    if not experiment_path.exists():
        print(f"Error: Directory not found: {experiment_dir}")
        return
    
    # Find all temp result files
    temp_files = list(experiment_path.glob("temp_results_*.csv"))
    
    if not temp_files:
        print(f"No temp_results_*.csv files found in {experiment_dir}")
        return
    
    print(f"Found {len(temp_files)} temp result files")
    
    # Read and combine all CSV files
    all_dataframes = []
    
    for temp_file in temp_files:
        try:
            df = pd.read_csv(temp_file)
            if len(df) > 0:
                all_dataframes.append(df)
                print(f"  ✓ {temp_file.name}: {len(df)} rows")
            else:
                print(f"  ⚠ {temp_file.name}: empty file")
        except Exception as e:
            print(f"  ✗ {temp_file.name}: error reading - {e}")
    
    if not all_dataframes:
        print("No valid data found in temp files")
        return
    
    # Combine all dataframes
    combined_df = pd.concat(all_dataframes, ignore_index=True)
    
    print(f"\nCombined dataset: {len(combined_df)} total rows")
    
    # Save merged results
    output_file = experiment_path / "merged_results.csv"
    combined_df.to_csv(output_file, index=False)
    
    print(f"✓ Merged results saved to: {output_file}")
    
    # Show summary by key columns if they exist
    if 'load_level' in combined_df.columns and 'L' in combined_df.columns and 'k_value' in combined_df.columns:
        print(f"\nSummary by test parameters:")
        summary = combined_df.groupby(['load_level', 'L', 'k_value']).size().reset_index(name='count')
        print(summary.to_string(index=False))
        
        # Check for expected total
        expected_combinations = len(combined_df['load_level'].unique()) * len(combined_df['L'].unique()) * len(combined_df['k_value'].unique())
        if 'seed' in combined_df.columns:
            expected_combinations *= len(combined_df['seed'].unique())
        
        print(f"\nExpected combinations: {expected_combinations}")
        print(f"Actual results: {len(combined_df)}")
        print(f"Coverage: {len(combined_df)/expected_combinations*100:.1f}%" if expected_combinations > 0 else "")
    
    return str(output_file)

def main():
    experiment_dir = "/home/stephen-reilly/dev/virne/sfc_study_results/experiment_09.03.2025_130109"
    
    print("Merging temp results from experiment_09.03.2025_130109")
    print("=" * 60)
    
    output_file = merge_temp_results(experiment_dir)
    
    if output_file:
        print(f"\n✅ All temp files merged successfully!")
        print(f"📄 Final file: {output_file}")
    else:
        print(f"\n❌ Failed to merge files")

if __name__ == "__main__":
    main()