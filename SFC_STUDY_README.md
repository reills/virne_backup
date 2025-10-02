# Service Function Chain (SFC) Length Study - Comprehensive K Analysis

## Overview
This study measures how Service Function Chain length (L) and k-shortest paths (k) affect acceptance ratio under different load levels (low/medium/high), with comprehensive testing of k=1 through k=15 and careful attribution of failures to routing vs CPU constraints.

## Experimental Design

### Variables
- **Chain Length (L)**: {2, 3, 4, 5, 6, 7, 8, 9, 10} (comprehensive range within model max_seq_len=15)
- **K-shortest paths**: {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15} (comprehensive k analysis)
- **Load Levels** (PNC regime only):
  - **Low Load**: 20 CPU per VNF, 10 BW
  - **Medium Load**: 25 CPU per VNF, 14 BW  
  - **High Load**: 30 CPU per VNF, 18 BW
  - **Random Load**: 20-30 CPU per VNF (uniform), 10-18 BW (uniform), 2-10 chain length (uniform)

### Controls
- **Physical Network**: Same 100-node topology across all tests
- **Paired Comparison**: Same VNR set tested across all k-values
- **Fixed Parameters**: Arrival patterns (lam=20.0), lifetimes, solver settings
- **Sample Size**: 1000 VNRs per (L, regime, seed) × 2 seeds = 2000 VNRs per condition

### Directory Structure
```
/dataset/large/
  PNC_low/size_2/seed_1/      # Low load, L=2, seed 1
  PNC_low/size_2/seed_2/      # Low load, L=2, seed 2
  ...
  PNC_medium/size_10/seed_5/  # Medium load, L=10, seed 5
  PNC_high/size_10/seed_5/    # High load, L=10, seed 5
  PNC_random/size_0/seed_1/   # Random load, random L, seed 1
```

## Implementation

### 1. Dataset Generation (`generate_sfc_datasets.py`)
- Uses existing VirtualNetworkRequestSimulator
- Creates controlled VNR sets for each (L, load_level, seed) combination
- Ensures consistent physical network across all conditions
- Generates deterministic VNR sets using seed control
- Incorporates load-dependent arrival rates and resource constraints

**Usage:**
```bash
# Full study
python generate_sfc_datasets.py --lengths 2 3 4 5 6 7 8 9 10 --loads low medium high

# Include random load level
python generate_sfc_datasets.py --lengths 2 3 4 5 6 7 8 9 10 --loads low medium high random

# Quick test
python generate_sfc_datasets.py --quick-test
```

### 2. Controlled Testing (`test_sfc_study.py`)
- Implements paired comparison methodology
- Tests each VNR set across comprehensive k-values (1-15)
- Records detailed acceptance ratios and failure attribution
- Uses existing trained k-specific models

**Usage:**
```bash
# Auto-find latest datasets and test with all k-values
python test_sfc_study.py --auto-find

# Test specific k-values
python test_sfc_study.py --auto-find --k-values 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15

# Quick test
python test_sfc_study.py --quick-test
```

### 3. End-to-End Execution (`run_sfc_study.py`)
- Convenience script for complete study
- Handles both dataset generation and testing

**Usage:**
```bash
# Full study
python run_sfc_study.py --full

# Quick verification
python run_sfc_study.py --quick

# Just generate datasets
python run_sfc_study.py --generate-only

# Just run tests
python run_sfc_study.py --test-only
```

## Key Features

### Paired Comparison Protocol
For each (load_level, L, seed) combination:
1. Generate VNRs with fixed seed for reproducibility
2. Test the **same VNR set** across all k-values {1,2,3,...,15}
3. This ensures fair comparison by controlling for VNR difficulty

### Load Level Calculations
- **Low Load**: per-VNF CPU = 20, total CPU = 20×L, BW = 10, arrival = 20.0 lam
  - L=2: 40 total CPU, L=5: 100 total CPU, L=10: 200 total CPU
- **Medium Load**: per-VNF CPU = 25, total CPU = 25×L, BW = 14, arrival = 20.0 lam
  - L=2: 50 total CPU, L=5: 125 total CPU, L=10: 250 total CPU
- **High Load**: per-VNF CPU = 30, total CPU = 30×L, BW = 18, arrival = 20.0 lam
  - L=2: 60 total CPU, L=5: 150 total CPU, L=10: 300 total CPU
- **Random Load**: per-VNF CPU = 20-30 (uniform), BW = 10-18 (uniform), L = 2-10 (uniform), arrival = 20.0 lam
  - Variable total CPU and resources based on random generation

### Output Data Structure
Results CSV contains:
- `load_level`: low, medium, high, or random
- `L`: Chain length
- `seed`: Random seed used
- `k_value`: K-shortest paths setting (1-15)
- `acceptance_ratio`: Success rate
- `v_net_count`: Total VNRs processed
- `success_count`: Successful embeddings
- `failure_info`: Detailed failure attribution

## Expected Outcomes

### Hypotheses to Test
1. **Chain Length Effect**: Longer chains (higher L) should have lower acceptance ratios
2. **K-value Effect**: Higher k should improve acceptance ratios, with potential plateaus
3. **Load Level Interaction**: 
   - Low Load: Should have highest acceptance ratios across all L and k
   - Medium Load: Moderate acceptance ratios
   - High Load: Lowest acceptance ratios, more sensitive to k improvements
   - Random Load: Variable performance depending on generated resource values and chain lengths
4. **K-value Diminishing Returns**: Benefits of increasing k may plateau beyond certain values
5. **Failure Attribution**: Understand whether failures are primarily routing-limited or CPU-limited

### Analysis Questions
1. How does acceptance ratio change with L for each load level?
2. How much does increasing k improve acceptance ratio (comprehensive k=1-15)?
3. At what k-value do we see diminishing returns for different L and load combinations?
4. Do the benefits of higher k vary with chain length and load level?
5. Which load level performs best for different chain lengths?
6. What are the primary failure causes (routing vs CPU) for each condition?
7. Is there an optimal k-value for each (L, load_level) combination?

## Data Hygiene

### Dataset Reuse Protocol
- `renew_v_net_simulator=True`: First time generating a dataset
- `renew_v_net_simulator=False`: Reusing existing VNRs for different k-values
- `reuse_existing_p=True`: Always reuse the same physical network
- `reuse_existing_v=True`: When testing multiple k-values on same VNR set

### File Organization
Each dataset directory contains:
- `p_net.gml`: Physical network (identical across all conditions)
- `v_nets/`: Directory with 200 VNR files (v_net-00000.gml to v_net-00199.gml)
- `events.yaml`: Event schedule for request arrivals/departures
- `v_sim_setting.yaml`: VNR generation parameters used
- `generation_config.json`: Resource configuration metadata

## Running the Study

### Prerequisites
- Trained k-specific models for k={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15} on large topology
- Available in `k_specific_training/run_*/trained_models_registry.json`

### Quick Start
```bash
# Generate datasets
python generate_sfc_datasets.py --quick-test

# Run comprehensive k=1-15 testing  
python test_sfc_study.py --auto-find

# Quick verification test
python test_sfc_study.py --quick-test
```

### Monitoring Progress
- Dataset generation: ~2-5 minutes per (L, load_level, seed) combination
- Testing: ~1-2 minutes per (L, load_level, seed, k) test
- Total time estimate: 6-12 hours for full study (due to comprehensive k=1-15 testing)

### Results Location
- **Datasets**: `sfc_datasets/generation_*/`
- **Test Results**: `sfc_study_results/experiment_*/`
- **Summary CSV**: `sfc_study_results_*.csv`

## Next Steps After Data Collection

1. **Acceptance Ratio Analysis**: Plot L vs acceptance ratio for each k and load level
2. **Comprehensive K-value Impact**: Quantify improvement across k=1-15 range
3. **Diminishing Returns Analysis**: Identify optimal k-values for different conditions
4. **Load Level Comparison**: Compare low/medium/high load performance
5. **Failure Attribution**: Analyze routing vs CPU failure patterns
6. **Optimal K Identification**: Find best k-value for each (L, load_level) combination
7. **Statistical Testing**: Assess significance of observed differences

This experimental design ensures rigorous control while providing comprehensive data on SFC length effects across the full k=1-15 range and multiple load levels, enabling detailed analysis of k-value optimization for different network conditions.