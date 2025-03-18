# ==============================================================================
# pretraining.py (Refactored Transformer for Autoregressive Decoding + Checkpoint Resumption)
# ==============================================================================
# pretraining.py
import os
import time
import warnings
import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.functional as F
from torch.utils.data import DataLoader, Dataset, random_split
from torch_geometric.data import Data, Batch
from torch.nn.utils.rnn import pad_sequence
from torch.optim.lr_scheduler import ReduceLROnPlateau

from .net import ActorCritic 

# --- Dataset Class ---
class BehaviorCloningDataset(Dataset):
    def __init__(self, data_path):
        with open(data_path, 'rb') as f, warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning, message=".*weights_only=False.*")
            self.samples = torch.load(f, weights_only=False)
        # Validate data
        for i, sample in enumerate(self.samples):
            for key, value in sample.items():
                if torch.is_tensor(value) and (torch.isnan(value).any() or torch.isinf(value).any()):
                    raise ValueError(f"NaN or Inf found in sample {i}, key {key}")

    def __len__(self):
        return len(self.samples)

    def __getitem__(self, idx):
        return self.samples[idx]

# --- Data Collation ---
def collate_fn(batch):
    p_net_data = [
        get_pyg_data(s['p_net_x'], s['p_net_edge_index'], s['edge_attr'])
        for s in batch
    ]
    p_net_batch = Batch.from_data_list(p_net_data)
    v_net_x = torch.stack([s['v_net_x'] for s in batch])
    history_actions = pad_sequence([s['history_actions'].long() for s in batch],
                                   batch_first=True, padding_value=0)
    action_mask = torch.stack([s['action_mask'] for s in batch])
    actions = torch.stack([s['action'] for s in batch])
    target_value = torch.stack([s['target_value'] for s in batch])
    return {
        'p_net': p_net_batch,
        'p_net_x': p_net_batch.x,
        'v_net_x': v_net_x,
        'history_actions': history_actions,
        'action_mask': action_mask,
        'actions': actions,
        'target_value': target_value
    }

def get_pyg_data(x, edge_index, edge_attr=None, device='cuda'):
    x = torch.as_tensor(x, dtype=torch.float32).to(device)
    edge_index = torch.as_tensor(edge_index, dtype=torch.long).to(device)
    if edge_attr is not None:
        edge_attr = torch.as_tensor(edge_attr, dtype=torch.float32).to(device)
    return Data(x=x, edge_index=edge_index, edge_attr=edge_attr)

# --- Evaluation Function ---
def evaluate(model, dataloader, device):
    model.eval()
    total_actor_loss = 0.0
    total_critic_loss = 0.0
    total_accuracy = 0.0
    total_valid_samples = 0
    total_samples = 0

    with torch.no_grad():
        for batch_data in dataloader:
            batch_data = {k: v.to(device) if isinstance(v, torch.Tensor) else v for k, v in batch_data.items()}
            encoder_inputs = encoder_obs_to_tensor({'v_net_x': batch_data['v_net_x']}, device)
            encoder_outputs = model.encode(encoder_inputs)
            batch_data['encoder_outputs'] = encoder_outputs

            # Actor evaluation (only on valid samples)
            logits = model.act(batch_data)
            invalid_mask = (batch_data['action_mask'] < 0.5)
            logits = logits.masked_fill(invalid_mask, float('-inf'))
            logits = torch.clamp(logits, min=-1e9, max=1e9)

            decoder_targets = batch_data['actions']
            valid_mask = decoder_targets >= 0
            num_valid = valid_mask.sum().item()
            num_samples = batch_data['target_value'].size(0)

            if num_valid > 0:
                valid_logits = logits[valid_mask]
                valid_targets = decoder_targets[valid_mask]
                actor_loss = F.cross_entropy(valid_logits, valid_targets)
                preds = valid_logits.argmax(dim=-1)
                accuracy = (preds == valid_targets).float().mean().item()
            else:
                actor_loss = 0.0
                accuracy = 0.0

            # Critic evaluation (all samples)
            predicted_values = model.evaluate(batch_data).squeeze(-1)
            critic_loss = F.mse_loss(predicted_values, batch_data['target_value'])

            total_actor_loss += actor_loss * num_valid if num_valid > 0 else 0
            total_critic_loss += critic_loss.item() * num_samples
            total_accuracy += accuracy * num_valid if num_valid > 0 else 0
            total_valid_samples += num_valid
            total_samples += num_samples

    avg_actor_loss = total_actor_loss / total_valid_samples if total_valid_samples > 0 else 0.0
    avg_critic_loss = total_critic_loss / total_samples if total_samples > 0 else 0.0
    avg_accuracy = total_accuracy / total_valid_samples if total_valid_samples > 0 else 0.0
    return avg_actor_loss, avg_critic_loss, avg_accuracy


# --- Training Function ---
def train_transformer(
    data_file, checkpoint_file="pretrained_transformer.pth", epochs=1000, batch_size=128, 
    lr_actor=1e-4, device='cuda', p_net_feature_dim=3, v_net_feature_dim=3, p_net_num_nodes=100,
    start_epoch=0, checkpoint=None, val_split=0.1, test_split=0.1, entropy_coef=0.01
):
    dataset = BehaviorCloningDataset(data_file)
    total_samples = len(dataset)
    train_size = int((1.0 - val_split - test_split) * total_samples)
    val_size = int(val_split * total_samples)
    test_size = total_samples - train_size - val_size

    train_dataset, val_dataset, test_dataset = random_split(dataset, [train_size, val_size, test_size])
    train_loader = DataLoader(train_dataset, batch_size=batch_size, shuffle=True, 
                              collate_fn=collate_fn, drop_last=True)
    val_loader = DataLoader(val_dataset, batch_size=batch_size, shuffle=False, 
                            collate_fn=collate_fn, drop_last=False)
    test_loader = DataLoader(test_dataset, batch_size=batch_size, shuffle=False, 
                             collate_fn=collate_fn, drop_last=False)

    model = ActorCritic(p_net_num_nodes, p_net_feature_dim, v_net_feature_dim).to(device)
    optimizer = optim.Adam(model.parameters(), lr=lr_actor, weight_decay=1e-5)
    scheduler = ReduceLROnPlateau(optimizer, mode='min', factor=0.5, patience=15, verbose=True)

    if checkpoint:
        model.load_state_dict(checkpoint['model_state_dict'])
        optimizer.load_state_dict(checkpoint['optimizer_state_dict'])
        start_epoch = checkpoint.get('epoch', 0)
        print(f"Resumed training from checkpoint at epoch {start_epoch}...")

    best_val_loss = float('inf')
    patience = 35
    epochs_no_improve = 0
    min_delta = 0.001

     # Lists to store metrics for plotting (only key metrics for an academic-style plot)
    epoch_nums = []
    train_total_losses = []   # Sum of actor and critic loss during training
    val_total_losses = []     # Sum of validation actor and critic losses


    print("\nTraining started...\n")
    for epoch in range(start_epoch, epochs):
        model.train()
        actor_loss_total = 0.0
        critic_loss_total = 0.0
        actor_acc_total = 0.0
        num_batches = 0
        start_time = time.time()

        for batch_data in train_loader:
            batch_data = {k: v.to(device) if isinstance(v, torch.Tensor) else v 
                        for k, v in batch_data.items()}

            # Obtain encoder outputs for the critic
            encoder_inputs = encoder_obs_to_tensor({'v_net_x': batch_data['v_net_x']}, device)
            encoder_outputs = model.encode(encoder_inputs)
            batch_data['encoder_outputs'] = encoder_outputs

            ## Actor Forward and Loss (only on successful samples)
            actor_logits = model.act(batch_data)  # (batch_size, num_p_nodes)
            invalid_mask = (batch_data['action_mask'] < 0.5)
            actor_logits = actor_logits.masked_fill(invalid_mask, float('-inf'))
            actor_logits = torch.clamp(actor_logits, min=-1e9, max=1e9)

            # Compute actor loss only on samples with valid actions (action != -1)
            valid_actor_mask = batch_data['actions'] >= 0
            if valid_actor_mask.sum() > 0:
                valid_logits = actor_logits[valid_actor_mask]
                valid_targets = batch_data['actions'][valid_actor_mask]
                actor_loss = F.cross_entropy(valid_logits, valid_targets)
                # Compute actor accuracy for valid samples
                preds = valid_logits.argmax(dim=-1)
                actor_acc = (preds == valid_targets).float().mean().item()
            else:
                actor_loss = torch.tensor(0.0, device=device)
                actor_acc = 0.0

            ## Critic Forward and Loss (for all samples)
            predicted_values = model.evaluate(batch_data).squeeze(-1)
            critic_loss = F.mse_loss(predicted_values, batch_data['target_value'])

            ## Combine Losses and Backpropagate
            total_loss = actor_loss + critic_loss
            optimizer.zero_grad()
            total_loss.backward()
            torch.nn.utils.clip_grad_norm_(model.parameters(), max_norm=0.5)
            optimizer.step()

            actor_loss_total += actor_loss.item()
            critic_loss_total += critic_loss.item()
            actor_acc_total += actor_acc
            num_batches += 1

        avg_actor_loss = actor_loss_total / num_batches
        avg_critic_loss = critic_loss_total / num_batches
        avg_actor_acc = actor_acc_total / num_batches
        elapsed_time = time.time() - start_time

        val_actor_loss, val_critic_loss, val_accuracy = evaluate(model, val_loader, device)
        val_total_loss = val_actor_loss + val_critic_loss  # Combine for scheduling
        print(f"Epoch {epoch+1}/{epochs} → Actor Loss: {avg_actor_loss:.4f} | Actor Acc: {avg_actor_acc:.4f} | "
              f"Critic Loss: {avg_critic_loss:.4f} | Val Actor Loss: {val_actor_loss:.4f} | "
              f"Val Critic Loss: {val_critic_loss:.4f} | Val Acc: {val_accuracy:.4f} | Time: {elapsed_time:.2f}s")
            
        scheduler.step(val_total_loss)  # Use combined loss for scheduling
        
        # Store key metrics for plotting
        epoch_nums.append(epoch+1)
        train_total_losses.append(avg_actor_loss + avg_critic_loss)
        val_total_losses.append(val_total_loss)

        if val_total_loss < best_val_loss - min_delta:
            best_val_loss = val_total_loss
            epochs_no_improve = 0
            torch.save({
                'model_state_dict': model.state_dict(),
                'optimizer_state_dict': optimizer.state_dict(),
                'epoch': epoch + 1
            }, checkpoint_file)
            print(f"Checkpoint saved at epoch {epoch+1} (new best val loss: {best_val_loss:.4f}).")
        else:
            epochs_no_improve += 1
            print(f"Epochs without improvement: {epochs_no_improve}/{patience}")

        if epochs_no_improve >= patience:
            print("Early stopping triggered!")
            break

    test_actor_loss, test_critic_loss, test_accuracy = evaluate(model, test_loader, device)
    print(f"Test Actor Loss: {test_actor_loss:.4f} | Test Critic Loss: {test_critic_loss:.4f} | "
          f"Test Accuracy: {test_accuracy:.4f}")
          
    torch.save({
        'model_state_dict': model.state_dict(),
        'optimizer_state_dict': optimizer.state_dict(),
        'epoch': epochs
    }, "pretrained_transformer_final.pth")
    print("Final model and optimizer saved.")
 
    return model, optimizer

def encoder_obs_to_tensor(obs, device):
    if isinstance(obs, dict):
        if torch.is_tensor(obs['v_net_x']):
            obs_v_net_x = obs['v_net_x'].float().to(device)
        else:
            obs_v_net_x = torch.tensor(obs['v_net_x'], dtype=torch.float32, device=device)
        return {'v_net_x': obs_v_net_x}
    elif isinstance(obs, list):
        obs_batch = [
            torch.tensor(o['v_net_x'], dtype=torch.float32, device=device)
            if not torch.is_tensor(o['v_net_x']) else o['v_net_x'].float().to(device)
            for o in obs
        ]
        padded = pad_sequence(obs_batch, batch_first=True)
        return {'v_net_x': padded}
    else:
        raise Exception(f"Unrecognized type of observation {type(obs)}")


# --- Training Execution ---
if __name__ == "__main__":
    dataset_path = "/home/stephen-reilly/development/virne/dataset/training-data/merged_training_data.pt"
    checkpoint_path = "behavioral_cloning_checkpoint.pth"

    if not os.path.exists(dataset_path):
        raise FileNotFoundError(f"Dataset not found at {dataset_path}. Please generate it first.")

    with warnings.catch_warnings():
        warnings.filterwarnings("ignore", category=UserWarning, message=".*weights_only=False.*")
        dataset = torch.load(dataset_path, weights_only=False)
    if not dataset:
        raise ValueError(f"Dataset at {dataset_path} is empty.")

    sample = dataset[0]
    v_net_feature_dim = sample['v_net_x'].shape[1]
    p_net_feature_dim = sample['p_net_x'].shape[1]
    print(f"Loaded dataset with {len(dataset)} samples.")
    print(f"v_net_feature_dim: {v_net_feature_dim}, p_net_feature_dim: {p_net_feature_dim}")

    device = "cuda" if torch.cuda.is_available() else "cpu"
    print(f"Using device: {device}")

    checkpoint = None
    start_epoch = 0
    if os.path.exists(checkpoint_path):
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=UserWarning, message=".*weights_only=False.*")
            checkpoint = torch.load(checkpoint_path, map_location=device, weights_only=False)
            start_epoch = checkpoint.get('epoch', 0)
            print(f"Checkpoint found at {checkpoint_path}, resuming from epoch {start_epoch}.")
    else:
        print(f"No checkpoint found at {checkpoint_path}, starting from epoch 0.")

    trained_model, optimizer = train_transformer(
        data_file=dataset_path,
        checkpoint_file=checkpoint_path,
        device=device,
        p_net_feature_dim=p_net_feature_dim,
        v_net_feature_dim=v_net_feature_dim,
        p_net_num_nodes=100,
        start_epoch=start_epoch,
        checkpoint=checkpoint,
        val_split=0.1,
        test_split=0.1
    )
 
 