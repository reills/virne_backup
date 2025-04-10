# import torch

# path = "/home/stephen-reilly/dev/virne/dataset/training-data/training_data_GG1_20250403_053636.pt"
# dataset = torch.load(path, map_location='cpu')

# print(f"Dataset size: {len(dataset)}")

# for i, sample in enumerate(dataset):
#     print(f"\n--- Sample {i} ---")
#     for key, value in sample.items():
#         print(f"\n{key}:")
#         if torch.is_tensor(value):
#             if value.ndim <= 2 and value.numel() < 100:
#                 print(value)  # print small/flat tensors directly
#             else:
#                 print(value[:2])  # print first 2 elements/slices for larger tensors
#         else:
#             print(value)

#     if i >= 2:  # limit to first 3 samples
#         break

    

import os
import re
import torch
import warnings
 
def merge_pt_files(directory, output_filename="merged_training_data.pt"):
    """
    Merges all .pt files in the given directory into one file.

    Args:
        directory (str): Absolute path to the directory containing the .pt files.
        output_filename (str): Name of the output file.
    """
    if not os.path.isdir(directory):
        raise ValueError(f"Directory {directory} does not exist.")
    
    # Collect .pt files and sort using natural order
    files = [f for f in os.listdir(directory)
             if f.endswith(".pt") and f != output_filename and f != "precomputed_norm.pt"] 
    
    merged_data = []
    loaded_count = 0

    for filename in files:
        file_path = os.path.join(directory, filename)
        try:
            print(f"Loading file: {file_path}")
            with warnings.catch_warnings():
                warnings.filterwarnings("ignore", category=UserWarning, message=".*weights_only=False.*") 
                data = torch.load(file_path, map_location='cpu', weights_only=False)
            if isinstance(data, list):
                merged_data.extend(data)
            else:
                merged_data.append(data)
            loaded_count += 1
        except Exception as e:
            print(f"Error loading {file_path}: {e}")
    
    print(f"Loaded {loaded_count} files in total.")
    
    if merged_data:
        output_path = os.path.join(directory, output_filename)
        try:
            torch.save(merged_data, output_path)
            print(f"Merged data saved to: {output_path}")
            
            data = torch.load("/home/stephen-reilly/dev/virne/dataset/merged_training_data.pt")
            p_samples = torch.cat([s['p_net_x'].float() for s in data], dim=0)
            v_samples = torch.cat([s['v_net_x'].float() for s in data], dim=0)

            norm_vector_p = torch.max(p_samples, dim=0)[0]
            norm_vector_v = torch.max(v_samples, dim=0)

            torch.save({'norm_vector_p': norm_vector_p, 'norm_vector_v': norm_vector_v}, "dataset/precomputed_norm.pt")


        except Exception as e:
            print(f"Error saving merged data to {output_path}: {e}")
    else:
        print("No valid .pt files were found to merge.")

if __name__ == "__main__":
    training_data_directory = "/home/stephen-reilly/dev/virne/dataset/training-data"
    merge_pt_files(training_data_directory)
