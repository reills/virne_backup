# ==============================================================================
# pretraining.py (Refactored Transformer for Autoregressive Decoding + Checkpoint Resumption)
# ==============================================================================
# batch_pretraining.py
import os
import time
import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.functional as F
from torch.utils.data import DataLoader, Dataset, random_split
from torch_geometric.data import Data, Batch
from torch.optim.lr_scheduler import ReduceLROnPlateau

from .net import BatchPlacementNet  # <-- updated import

class BehaviorCloningDataset(Dataset):
    def __init__(self, data_path):
        with open(data_path, 'rb') as f:
            self.samples = torch.load(f, weights_only=False)

    def __len__(self):
        return len(self.samples)

    def __getitem__(self, idx):
        return self.samples[idx]

def collate_fn(batch):
    p_net_data = [
        Data(
            x=s['p_net_x'].clone().detach().float(),
            edge_index=s['p_net_edge_index'].clone().detach().long(),
            edge_attr=s['edge_attr'].clone().detach().float()
        ) for s in batch
    ]
    p_net_batch = Batch.from_data_list(p_net_data)

    v_net_x = torch.stack([s['v_net_x'] for s in batch], dim=0)     # (B, 8, 6)
    actions = torch.stack([s['action'] for s in batch])             # (B, 8)
    target_value = torch.stack([s['target_value'] for s in batch])  # (B,)
    action_mask = torch.stack([s['action_mask'] for s in batch])  # (B, 8, 100)
    history_actions = torch.stack([s['history_actions'] for s in batch])  # (B, 8, window_size)


    return {
        'p_net': p_net_batch,
        'p_net_x': p_net_batch.x,
        'p_net_edge_index': p_net_batch.edge_index,
        'edge_attr': p_net_batch.edge_attr,       # ✅ Add this
        'v_net_x': v_net_x,
        'actions': actions,
        'action_mask': action_mask,
        'history_actions': history_actions,
        'target_value': target_value
    }


def evaluate(model, dataloader, device):
    model.eval()
    total_actor_loss, total_critic_loss, total_accuracy = 0.0, 0.0, 0.0
    total_samples = 0

    with torch.no_grad():
        for batch in dataloader:
            batch = {k: v.to(device) for k, v in batch.items() if isinstance(v, torch.Tensor)}

            logits = model(batch['p_net_x'], batch['p_net_edge_index'], batch['edge_attr'], batch['v_net_x'],batch['history_actions'] )
            mask = batch['action_mask']
            masked_logits = logits.masked_fill(mask == 0, -1e9)

            logits_flat = masked_logits.view(-1, masked_logits.size(-1))
            targets_flat = batch['actions'].view(-1)

            actor_loss = F.cross_entropy(logits_flat, targets_flat)
            preds = logits_flat.argmax(dim=-1)
            acc = (preds == targets_flat).float().mean().item()

            critic_pred = model.evaluate(batch['p_net_x'], batch['p_net_edge_index'], batch['edge_attr'], batch['v_net_x'],batch['history_actions'] )
            critic_loss = F.mse_loss(critic_pred, batch['target_value'])

            total_actor_loss += actor_loss.item() * targets_flat.size(0)
            total_critic_loss += critic_loss.item() * targets_flat.size(0)
            total_accuracy += acc * targets_flat.size(0)
            total_samples += targets_flat.size(0)

    return total_actor_loss / total_samples, total_critic_loss / total_samples, total_accuracy / total_samples


def train_transformer(data_file, checkpoint_file, device='cuda', epochs=1000, batch_size=128, lr=1e-4):
    dataset = BehaviorCloningDataset(data_file)
    train_size = int(0.8 * len(dataset))
    val_size = int(0.1 * len(dataset))
    test_size = len(dataset) - train_size - val_size

    train_set, val_set, test_set = random_split(dataset, [train_size, val_size, test_size])
    train_loader = DataLoader(train_set, batch_size=batch_size, shuffle=True, collate_fn=collate_fn)
    val_loader = DataLoader(val_set, batch_size=batch_size, shuffle=False, collate_fn=collate_fn)
    test_loader = DataLoader(test_set, batch_size=batch_size, shuffle=False, collate_fn=collate_fn)

    sample = dataset[0]
    v_dim = sample['v_net_x'].shape[-1]
    p_dim = sample['p_net_x'].shape[-1]

    model = BatchPlacementNet(p_net_num_nodes=100, p_net_feature_dim=p_dim, v_net_feature_dim=v_dim,embedding_dim=128).to(device)
    optimizer = optim.Adam(model.parameters(), lr=lr)
    scheduler = ReduceLROnPlateau(optimizer, mode='min', patience=10)

    best_val_loss = float('inf')
    for epoch in range(epochs):
        model.train()
        total_loss, total_acc = 0.0, 0.0

        for batch in train_loader:
            batch = {k: v.to(device) for k, v in batch.items() if isinstance(v, torch.Tensor)}
            logits = model(batch['p_net_x'], batch['p_net_edge_index'], batch['edge_attr'], batch['v_net_x'],batch['history_actions'] )
            mask = batch['action_mask']     # mask:   (B, 8, 100)
            masked_logits = logits.masked_fill(mask == 0, -1e9) 

            # Now compute loss using masked logits
            logits_flat = masked_logits.view(-1, masked_logits.size(-1))
            targets_flat = batch['actions'].view(-1)
            actor_loss = F.cross_entropy(logits_flat, targets_flat)

            preds = logits_flat.argmax(dim=-1)
            acc = (preds == targets_flat).float().mean().item()

            critic_pred = model.evaluate(batch['p_net_x'], batch['p_net_edge_index'], batch['edge_attr'], batch['v_net_x'],batch['history_actions'] )
            critic_loss = F.mse_loss(critic_pred, batch['target_value'])

            loss = actor_loss + critic_loss
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()

            total_loss += loss.item()
            total_acc += acc

        val_loss, val_critic_loss, val_acc = evaluate(model, val_loader, device)
        scheduler.step(val_loss)

        print(f"Epoch {epoch+1} | Train Loss: {total_loss:.4f}, Train Acc: {total_acc/len(train_loader):.4f} | Val Loss: {val_loss:.4f}, Val Acc: {val_acc:.4f}")

        if val_loss < best_val_loss:
            best_val_loss = val_loss
            torch.save(model.state_dict(), checkpoint_file)
            print(f"Checkpoint saved at epoch {epoch+1}.")

    test_loss, test_critic_loss, test_acc = evaluate(model, test_loader, device)
    print(f"Test Loss: {test_loss:.4f}, Test Acc: {test_acc:.4f}")

if __name__ == "__main__":
    data_path = "/home/stephen-reilly/dev/virne/dataset/training-data/training_data_GG2_20250403_055841.pt"
    checkpoint_path = "batch_transformer_checkpoint.pth"
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    train_transformer(data_file=data_path, checkpoint_file=checkpoint_path, device=device)

