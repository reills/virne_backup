
import torch
import os


dataset_path = "dataset/training-data/merged_training_data.pt"
dataset = torch.load(dataset_path)

total_samples = 0
zero_mask_count = 0

for i, sample  in  enumerate(dataset):
    if( i == 48):
        print(sample)
    total_samples += 1

print(f"Total samples: {total_samples}")
print(f"Samples with fully zero action masks: {zero_mask_count} ({zero_mask_count / total_samples:.2%})")

cleaned_dataset = [sample for sample in dataset if sample['action_mask'].sum() > 0]
torch.save(cleaned_dataset, dataset_path)  # Overwrite the dataset
print(f"Filtered dataset saved with {len(cleaned_dataset)} samples.")


# import torch
# import os
# import glob

# def merge_pt_files(input_folder, output_file):
#     """
#     Merges all .pt files in the given folder into a single .pt file.
#     Each .pt file should contain a list of samples.
#     """
#     # Find all .pt files in the input folder
#     pt_files = sorted(glob.glob(os.path.join(input_folder, "*.pt")))

#     all_samples = []
#     for pt_file in pt_files:
#         print(f"Loading {pt_file} ...")
#         data = torch.load(pt_file)  # Each file should contain a list of samples
#         all_samples.extend(data)

#     # Save merged samples
#     print(f"Saving merged dataset to {output_file} ...")
#     torch.save(all_samples, output_file)
#     print(f"Done. Merged {len(pt_files)} files into {output_file}.")

# if __name__ == "__main__":
#     input_folder = "/home/stephen-reilly/development/virne/dataset/training-data"
#     output_file = "/home/stephen-reilly/development/virne/dataset/training-data/merged_training_data.pt"
#     merge_pt_files(input_folder, output_file)
