#!/usr/bin/env python3
"""
Plot k_shortest ablation study results
"""

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from pathlib import Path

def plot_k_shortest_results():
    """Plot the k_shortest ablation study results"""
    
    # Read results
    results_file = Path("ablation_results/ablation_results.csv")
    if not results_file.exists():
        print(f"Results file not found: {results_file}")
        print("Run ablation_phase2_only.py first to generate results")
        return
    
    df = pd.read_csv(results_file)
    
    # Filter only successful experiments
    df_success = df[df['success'] == True].copy()
    
    if len(df_success) == 0:
        print("No successful experiments found in results")
        return
    
    print(f"Plotting results from {len(df_success)} successful experiments")
    print(f"Network sizes: {df_success['network_size'].unique()}")
    print(f"K-shortest values: {sorted(df_success['k_shortest'].unique())}")
    
    # Set up plotting style
    plt.style.use('default')
    fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(16, 12))
    
    # Color palette for network sizes
    colors = {'small': '#2E8B57', 'medium': '#4169E1', 'large': '#DC143C'}
    
    # Plot 1: Line plot showing k_shortest effect for each network size
    ax1.set_title('K-Shortest Path Effect on Acceptance Rate', fontsize=14, fontweight='bold')
    
    for network_size in ['small', 'medium', 'large']:
        if network_size in df_success['network_size'].values:
            network_data = df_success[df_success['network_size'] == network_size].copy()
            network_data = network_data.sort_values('k_shortest')
            
            ax1.plot(network_data['k_shortest'], network_data['acceptance_rate'], 
                    marker='o', linewidth=3, markersize=8, 
                    color=colors[network_size], label=f'{network_size.title()} Network',
                    markerfacecolor='white', markeredgewidth=2, markeredgecolor=colors[network_size])
    
    ax1.set_xlabel('k_shortest Parameter', fontsize=12)
    ax1.set_ylabel('Acceptance Rate', fontsize=12)
    ax1.legend(fontsize=11)
    ax1.grid(True, alpha=0.3)
    ax1.set_xticks(sorted(df_success['k_shortest'].unique()))
    ax1.set_ylim(0, 1.0)
    
    # Plot 2: Bar plot comparing baseline (k=1) vs best k for each network
    ax2.set_title('Acceptance Rate: k=1 vs Best k', fontsize=14, fontweight='bold')
    
    baseline_data = []
    best_data = []
    network_labels = []
    
    for network_size in ['small', 'medium', 'large']:
        if network_size in df_success['network_size'].values:
            network_data = df_success[df_success['network_size'] == network_size]
            
            k1_rate = network_data[network_data['k_shortest'] == 1]['acceptance_rate'].iloc[0] if 1 in network_data['k_shortest'].values else 0
            best_rate = network_data['acceptance_rate'].max()
            
            baseline_data.append(k1_rate)
            best_data.append(best_rate)
            network_labels.append(network_size.title())
    
    x = np.arange(len(network_labels))
    width = 0.35
    
    bars1 = ax2.bar(x - width/2, baseline_data, width, label='k=1 (baseline)', 
                   color=[colors[net.lower()] for net in network_labels], alpha=0.6)
    bars2 = ax2.bar(x + width/2, best_data, width, label='Best k', 
                   color=[colors[net.lower()] for net in network_labels], alpha=1.0)
    
    ax2.set_xlabel('Network Size', fontsize=12)
    ax2.set_ylabel('Acceptance Rate', fontsize=12)
    ax2.set_xticks(x)
    ax2.set_xticklabels(network_labels)
    ax2.legend(fontsize=11)
    ax2.set_ylim(0, 1.0)
    
    # Add value labels on bars
    for bar in bars1:
        if bar.get_height() > 0:
            ax2.annotate(f'{bar.get_height():.3f}', 
                        xy=(bar.get_x() + bar.get_width()/2, bar.get_height()),
                        xytext=(0, 3), textcoords="offset points",
                        ha='center', va='bottom', fontsize=10)
    
    for bar in bars2:
        if bar.get_height() > 0:
            ax2.annotate(f'{bar.get_height():.3f}', 
                        xy=(bar.get_x() + bar.get_width()/2, bar.get_height()),
                        xytext=(0, 3), textcoords="offset points",
                        ha='center', va='bottom', fontsize=10)
    
    # Plot 3: Heatmap showing all results
    ax3.set_title('Acceptance Rate Heatmap', fontsize=14, fontweight='bold')
    
    pivot_df = df_success.pivot_table(values='acceptance_rate', 
                                     index='network_size', 
                                     columns='k_shortest', 
                                     aggfunc='mean')
    
    # Reorder rows to match our preferred order
    if not pivot_df.empty:
        row_order = [idx for idx in ['small', 'medium', 'large'] if idx in pivot_df.index]
        pivot_df = pivot_df.reindex(row_order)
        
        sns.heatmap(pivot_df, annot=True, cmap='RdYlGn', ax=ax3, fmt='.3f',
                   cbar_kws={'label': 'Acceptance Rate'})
        ax3.set_xlabel('k_shortest Parameter', fontsize=12)
        ax3.set_ylabel('Network Size', fontsize=12)
    
    # Plot 4: Improvement over k=1 for each network size
    ax4.set_title('Relative Improvement over k=1', fontsize=14, fontweight='bold')
    
    for network_size in ['small', 'medium', 'large']:
        if network_size in df_success['network_size'].values:
            network_data = df_success[df_success['network_size'] == network_size].copy()
            network_data = network_data.sort_values('k_shortest')
            
            if 1 in network_data['k_shortest'].values:
                baseline = network_data[network_data['k_shortest'] == 1]['acceptance_rate'].iloc[0]
                improvement = ((network_data['acceptance_rate'] - baseline) / baseline * 100)
                
                ax4.plot(network_data['k_shortest'], improvement, 
                        marker='s', linewidth=3, markersize=8,
                        color=colors[network_size], label=f'{network_size.title()} Network',
                        markerfacecolor='white', markeredgewidth=2, markeredgecolor=colors[network_size])
    
    ax4.set_xlabel('k_shortest Parameter', fontsize=12)
    ax4.set_ylabel('Improvement over k=1 (%)', fontsize=12)
    ax4.legend(fontsize=11)
    ax4.grid(True, alpha=0.3)
    ax4.axhline(y=0, color='black', linestyle='--', alpha=0.5)
    ax4.set_xticks(sorted(df_success['k_shortest'].unique()))
    
    plt.tight_layout()
    
    # Save plots
    output_file = Path("ablation_results/k_shortest_analysis.png")
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    plt.savefig(Path("ablation_results/k_shortest_analysis.pdf"), bbox_inches='tight')
    
    print(f"\nPlots saved to:")
    print(f"  - {output_file}")
    print(f"  - ablation_results/k_shortest_analysis.pdf")
    
    plt.show()
    
    # Print summary statistics
    print("\n" + "="*60)
    print("SUMMARY STATISTICS")
    print("="*60)
    
    for network_size in ['small', 'medium', 'large']:
        if network_size in df_success['network_size'].values:
            network_data = df_success[df_success['network_size'] == network_size]
            print(f"\n{network_size.upper()} Network:")
            
            for _, row in network_data.sort_values('k_shortest').iterrows():
                print(f"  k={row['k_shortest']:2d}: {row['acceptance_rate']:.4f}")
            
            best_k = network_data.loc[network_data['acceptance_rate'].idxmax(), 'k_shortest']
            best_rate = network_data['acceptance_rate'].max()
            worst_rate = network_data['acceptance_rate'].min()
            
            print(f"  Best k: {best_k} (rate: {best_rate:.4f})")
            print(f"  Range: {worst_rate:.4f} - {best_rate:.4f} (Δ: {best_rate-worst_rate:.4f})")

def main():
    plot_k_shortest_results()

if __name__ == "__main__":
    main()