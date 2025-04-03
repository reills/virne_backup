# ==============================================================================
# net.py  (Enhanced Transformer with Deeper GAT and Improved Aggregation)
# ==============================================================================  
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch_geometric.nn import GATConv



# --- Multi-head GAT layer with skip connection and deeper structure ---
class MultiHeadGATSkipLayer(nn.Module):
    def __init__(self, in_dim, out_dim, heads=8, dropout=0.5):
        super().__init__()
        self.gat = GATConv(
            in_channels=in_dim,
            out_channels=out_dim,
            heads=heads,
            dropout=dropout,
            concat=True
        )
        self.skip = nn.Linear(in_dim, out_dim * heads, bias=False)
        self.norm = nn.LayerNorm(out_dim * heads)
        self.dropout = nn.Dropout(dropout)

        nn.init.xavier_uniform_(self.gat.lin.weight, gain=1.43)  # GATConv internal linear
        nn.init.zeros_(self.gat.bias)
        nn.init.xavier_uniform_(self.skip.weight, gain=1.0)

    def forward(self, x, edge_index):
        x = x.to(edge_index.device)
        #print(f"MultiHeadGATSkipLayer - Input x shape: {x.shape}, dtype: {x.dtype}")  # Add this
        #print(f"MultiHeadGATSkipLayer - edge_index shape: {edge_index.shape}, dtype: {edge_index.dtype}")  # Add this
        
        gat_out = self.gat(x, edge_index)
        skip_out = self.skip(x)
        out = self.norm(gat_out + 0.1 * skip_out)  # Scale skip connection

        out = F.elu(out)
        out = self.dropout(out)
        return out
    

class BatchPlacementNet(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, v_net_feature_dim,
                 embedding_dim=128, n_heads=8, n_layers=6, dropout=0.2):
        super().__init__()
        self.embedding_dim = embedding_dim
        self.p_net_num_nodes = p_net_num_nodes

        self.gat = MultiHeadGATSkipLayer(p_net_feature_dim, embedding_dim, heads=n_heads, dropout=dropout)

        self.v_emb = nn.Linear(v_net_feature_dim, embedding_dim)
        encoder_layer = nn.TransformerEncoderLayer(d_model=embedding_dim, nhead=n_heads, dropout=dropout, batch_first=True)
        self.v_encoder = nn.TransformerEncoder(encoder_layer, num_layers=n_layers)

        self.output_head = nn.Linear(embedding_dim * 2, p_net_num_nodes)

        self.value_head = nn.Sequential(
            nn.Linear(embedding_dim * 2, embedding_dim),
            nn.GELU(),
            nn.Linear(embedding_dim, 1)
        )

    def forward(self, p_net_x, p_edge_index, v_net_x):
        # Encode physical network
        p_emb = self.gat(p_net_x, p_edge_index)                     # (N_p, emb)
        p_global = p_emb.mean(dim=0, keepdim=True)                 # (1, emb)

        # Encode virtual network
        v_emb = self.v_emb(v_net_x)                                # (1, 8, emb)
        v_encoded = self.v_encoder(v_emb)                          # (1, 8, emb)

        # Repeat p_global for each v_node
        p_repeated = p_global.expand(v_encoded.shape[1], -1).unsqueeze(0)  # (1, 8, emb)

        # Combine and predict
        combined = torch.cat([v_encoded, p_repeated], dim=-1)      # (1, 8, 2*emb)
        logits = self.output_head(combined)                        # (1, 8, N_p)
        value = self.value_head(combined).mean(dim=1)              # (1, 1)

        return logits.squeeze(0), value.squeeze(0)
