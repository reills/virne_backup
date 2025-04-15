# ==============================================================================
# net.py  (Enhanced Transformer with Deeper GAT and Improved Aggregation)
# ==============================================================================  # net.py
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch_geometric.nn import GENConv


class MultiHeadGENLayer(nn.Module):
    def __init__(self, in_dim, out_dim, edge_dim=2, aggr='softmax'):
        super().__init__()
        self.conv = GENConv(
            in_channels=in_dim,
            out_channels=out_dim,
            edge_dim=edge_dim,
            aggr=aggr,
            t=1.0,
            learn_t=True,
            num_layers=2
        )
        self.norm = nn.LayerNorm(out_dim)
        self.dropout = nn.Dropout(0.1)

    def forward(self, x, edge_index, edge_attr):
        out = self.conv(x, edge_index, edge_attr)
        out = self.norm(out)
        out = F.elu(out)
        out = self.dropout(out)
        return out


class BatchPlacementNet(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, v_net_feature_dim,
                 embedding_dim=128, n_heads=8, n_layers=6, dropout=0.1):
        super().__init__()
        self.embedding_dim = embedding_dim
        self.n_heads = n_heads # Store n_heads
        self.p_net_num_nodes = p_net_num_nodes
        self.action_embed = nn.Embedding(self.p_net_num_nodes + 1, self.embedding_dim)

        

        #   output dim will be embedding_dim 
        self.gat_out_dim = embedding_dim  
        self.gat = MultiHeadGENLayer(p_net_feature_dim, embedding_dim, edge_dim=2)

        self.v_emb = nn.Linear(v_net_feature_dim, embedding_dim)
        encoder_layer = nn.TransformerEncoderLayer(d_model=embedding_dim, nhead=n_heads, dropout=dropout, batch_first=True)
        self.v_encoder = nn.TransformerEncoder(encoder_layer, num_layers=n_layers)

        # *** FIX HERE ***
        # Input dimension is concatenation of v_encoded (emb) and p_repeated (gat_out_dim)
        combined_dim_policy = embedding_dim + self.gat_out_dim + embedding_dim  # 128 + 1024 + 128 = 1280
        self.output_head = nn.Linear(combined_dim_policy, p_net_num_nodes)


        # *** FIX HERE ***
        # Input dimension is concatenation of v_global (emb) and p_global (gat_out_dim)
        combined_dim_value = embedding_dim + self.gat_out_dim + embedding_dim  # 128 + 1024 + 128
        self.value_head = nn.Sequential(
            nn.Linear(combined_dim_value, embedding_dim), # Corrected input size
            nn.GELU(),
            nn.Linear(embedding_dim, 1)
        )

    def forward(self, p_net_x, p_edge_index, edge_attr, v_net_x, history_actions, attn_mask=None):

        B = v_net_x.size(0)

        # Encode physical network
        p_emb = self.gat(p_net_x, p_edge_index, edge_attr)       # (N_p, 1024)
        p_global = p_emb.mean(dim=0, keepdim=True)               # (1, 1024)
        L = v_net_x.size(1)
        p_repeated = p_global.unsqueeze(1).expand(B, L, -1)

        # Encode virtual network
        v_emb = self.v_emb(v_net_x)                              # (B, 8, 128)
        v_encoded = self.v_encoder(v_emb, src_key_padding_mask=~attn_mask)  # invert mask for transformer
          # (B, 8, 128)

        # History encoding
        hist_emb = self.action_embed(history_actions)            # (B, 8, window, 128)
        hist_context = hist_emb.mean(dim=2)                      # (B, 8, 128)
        print("v_encoded shape:", v_encoded.shape)
        print("p_repeated shape:", p_repeated.shape)
        print("hist_context shape:", hist_context.shape)

        # Concatenate all
        #print(f"v_encoded.shape = {v_encoded.shape}")
        #print(f"p_repeated.shape = {p_repeated.shape}")
        #print(f"hist_context.shape = {hist_context.shape}")

        combined = torch.cat([v_encoded, p_repeated, hist_context], dim=-1)  # (B, 8, 1280)
        logits = self.output_head(combined)                      # (B, 8, N_p)
        return logits


    def evaluate(self, p_net_x, p_edge_index, edge_attr, v_net_x, history_actions, attn_mask=None):
        B = v_net_x.size(0)

        # Physical encoding
        p_emb = self.gat(p_net_x, p_edge_index, edge_attr)        # (N_p, gat_out_dim) -> (N_p, 1024)
        # Ensure p_global expansion is correct for value head input
        p_global = p_emb.mean(dim=0, keepdim=True).expand(B, -1)  # (B, gat_out_dim) -> (B, 1024)

        # Virtual encoding
        v_emb = self.v_emb(v_net_x)                    # (B, 8, emb) -> (B, 8, 128)
        v_encoded = self.v_encoder(v_emb, src_key_padding_mask=~attn_mask)
        v_global = (v_encoded * attn_mask.unsqueeze(-1)).sum(dim=1) / attn_mask.sum(dim=1, keepdim=True)
        
        v_global = (v_encoded * attn_mask.unsqueeze(-1)).sum(dim=1) / attn_mask.sum(dim=1, keepdim=True)

            
            
        # History encoding
        hist_emb = self.action_embed(history_actions)       # (B, 8, window_size, emb) 
        hist_context = self.action_embed(history_actions).mean(dim=2)
        hist_global = (hist_context * attn_mask.unsqueeze(-1)).sum(dim=1) / attn_mask.sum(dim=1, keepdim=True)


        # Combine for value prediction
        combined = torch.cat([v_global, p_global, hist_global], dim=-1)  # (B, emb + gat_out
        value = self.value_head(combined)                   # Expects (..., 1152) -> Outputs (B, 1)
        return value.squeeze(-1)                            # (B,)