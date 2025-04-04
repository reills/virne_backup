# ==============================================================================
# net.py  (Enhanced Transformer with Deeper GAT and Improved Aggregation)
# ==============================================================================  
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch_geometric.nn import GENConv

class MultiHeadGENLayer(nn.Module):
    def __init__(self, in_dim, out_dim, aggr='softmax', edge_dim=2):
        super().__init__()
        self.conv = GENConv(
            in_channels=in_dim,
            out_channels=out_dim,
            aggr=aggr,
            edge_dim=edge_dim,
            t=1.0,
            learn_t=True,
            num_layers=2
        )
        self.norm = nn.LayerNorm(out_dim)
        self.dropout = nn.Dropout(0.2)

    def forward(self, x, edge_index, edge_attr):
        out = self.conv(x, edge_index, edge_attr)
        out = self.norm(out)
        out = F.elu(out)
        out = self.dropout(out)
        return out


# --- ActorCritic Model ---
class ActorCritic(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, v_net_feature_dim,
                 embedding_dim=128, n_heads=8, n_layers=6, dropout=0.2, **kwargs):
        super().__init__()
        
        common_kwargs = dict(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout,
            **kwargs  # include allow_rejection, allow_revocable, etc.
        )
        
        self.encoder = Encoder(v_net_feature_dim, embedding_dim, n_heads, n_layers, dropout)
        self.actor = Actor(**common_kwargs)
        self.critic = Critic(**common_kwargs)

    def encode(self, obs):
        return self.encoder(obs['v_net_x'])

    def act(self, obs ):
        return self.actor(obs)

    def evaluate(self, obs):
        return self.critic(obs)

# --- Encoder Module ---
class Encoder(nn.Module):
    def __init__(self, v_net_feature_dim, embedding_dim=128, n_heads=8, n_layers=6, dropout=0.2):
        super().__init__()
        self.emb = nn.Linear(v_net_feature_dim, embedding_dim)
        encoder_layer = nn.TransformerEncoderLayer(
            d_model=embedding_dim,
            nhead=n_heads,
            dim_feedforward=4 * embedding_dim,
            dropout=dropout,
            batch_first=True,
            activation='gelu'  # Switch to GELU for better gradient flow
        )
        self.transformer_encoder = nn.TransformerEncoder(encoder_layer, num_layers=n_layers)
        self.norm = nn.LayerNorm(embedding_dim)
        # In Encoder
        nn.init.xavier_uniform_(self.emb.weight, gain=1.0)  # Linear layers often use gain=1
        for layer in self.transformer_encoder.layers:
            nn.init.xavier_uniform_(layer.linear1.weight, gain=1.43)  # Approximate gain for GELU
            nn.init.zeros_(layer.linear1.bias)
            nn.init.xavier_uniform_(layer.linear2.weight, gain=1.0)
            nn.init.zeros_(layer.linear2.bias)

    def forward(self, x):
        if x.dim() == 2:
            x = x.unsqueeze(0)
        elif x.dim() != 3:
            raise ValueError("v_net_x must be a 3D tensor (batch, seq_len, feature_dim)")
        x = self.emb(x)
        x = self.transformer_encoder(x)
        return self.norm(x)

# --- Actor Module ---
class Actor(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128,
                 n_heads=8, n_layers=6, dropout=0.2, **kwargs):
        super().__init__()
        # Retrieve special action flags from kwargs
        allow_revocable = kwargs.get("allow_revocable", False)
        allow_rejection = kwargs.get("allow_rejection", False)
        self.decoder = AutoregressiveDecoder(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout,
            is_actor=True, 
            allow_revocable=allow_revocable,
            allow_rejection=allow_rejection
        )

    def forward(self, obs):
        return self.decoder(obs)

# --- Critic Module ---
class Critic(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128,
                 n_heads=8, n_layers=6, dropout=0.2, **kwargs):
        super().__init__()
        # Retrieve special action flags from kwargs
        allow_revocable = kwargs.get("allow_revocable", False)
        allow_rejection = kwargs.get("allow_rejection", False)
        self.decoder = AutoregressiveDecoder(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout,
            is_actor=False,
            allow_revocable=allow_revocable,      # ← pass these through
            allow_rejection=allow_rejection
        )
        self.value_head = nn.Sequential(
            nn.Linear(embedding_dim, embedding_dim // 2),
            nn.GELU(),
            nn.Linear(embedding_dim // 2, 1)
        )

    def forward(self, obs):
        last_emb = self.decoder(obs, return_last_embed=True)
        return self.value_head(last_emb)

# --- Autoregressive Decoder ---
class AutoregressiveDecoder(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128,
                 n_heads=8, n_layers=6, dropout=0.2, is_actor=True,
                 allow_revocable=False, allow_rejection=False):
        super().__init__()
        self.embedding_dim = embedding_dim  # Save for later use in reshape
        # Calculate total number of actions
        self.num_actions = p_net_num_nodes + int(allow_rejection) + int(allow_revocable)
        self.start_token = self.num_actions
        self.pad_token = self.num_actions + 1  # ← NEW: actual pad token
        self.vocab_size = self.num_actions + 2  # ← accounts for both start_token and pad_token
        self.emb = nn.Embedding(self.vocab_size, embedding_dim)
        
        # Deeper GAT stack for better graph feature extraction
        self.gat_layers = nn.ModuleList([
            MultiHeadGENLayer(
                p_net_feature_dim if i == 0 else embedding_dim,
                embedding_dim
            )
            for i in range(3)
        ])
        self.gat_proj = nn.Identity()  # Optional: if you want a projection, use nn.Linear(embedding_dim, embedding_dim)

        decoder_layer = nn.TransformerDecoderLayer(
            d_model=embedding_dim,
            nhead=n_heads,
            dim_feedforward=4 * embedding_dim,
            dropout=dropout,
            batch_first=True,
            activation='gelu'
        )
        self.transformer_decoder = nn.TransformerDecoder(decoder_layer, num_layers=n_layers)
        self.norm = nn.LayerNorm(embedding_dim)

        # Output head
        self.is_actor = is_actor
        if is_actor:
            self.output_head = nn.Sequential(
                nn.Linear(2 * embedding_dim, embedding_dim),
                nn.GELU(),
                nn.Linear(embedding_dim, self.num_actions)
            )
        else:
            self.output_head = nn.Identity()  # Critic uses value_head in Critic class


    def forward(self, obs, return_last_embed=False, return_failure_pred=False):
        # Process physical network graph
        batch_p_net = obs['p_net']
        x, edge_index = batch_p_net.x, batch_p_net.edge_index
        edge_attr = batch_p_net.edge_attr

        for gat_layer in self.gat_layers:
            x = gat_layer(x, edge_index, edge_attr)

        graph_emb = self.gat_proj(x)
        graph_emb = graph_emb.reshape(batch_p_net.num_graphs, -1, self.embedding_dim)

        # Embed history actions
        tgt_seq = obs['history_actions']  # shape: (B, T)
        assert tgt_seq.max().item() < self.emb.num_embeddings, (
            f"Invalid index! Got {tgt_seq.max().item()}, but embedding size is {self.emb.num_embeddings}"
        )
        tgt_emb = self.emb(tgt_seq)  # shape: (B, T, E)

        # Transformer decode
        B, T, E = tgt_emb.shape
        causal_mask = torch.triu(torch.ones(T, T, device=tgt_emb.device), diagonal=1).bool()

        memory = obs['encoder_outputs']
        
        # Step 1: Identify padding positions
        padding_mask = (tgt_seq == self.pad_token)

        # Step 2: Transformer decode with key padding mask
        dec_out = self.transformer_decoder(
            tgt=tgt_emb,
            memory=memory,
            tgt_mask=causal_mask,
            tgt_key_padding_mask=padding_mask  # ← This is new
        )
 
        last_dec_out = dec_out[:, -1, :]  # shape: (B, E)

        # Optional: return embedding for critic or elsewhere
        if return_last_embed:
            return self.norm(last_dec_out)

        # Actor: Combine decoder output with GNN graph features
        expanded_dec_out = last_dec_out.unsqueeze(1).expand(-1, graph_emb.size(1), -1)
        combined = torch.cat([
            F.normalize(graph_emb, dim=-1),
            F.normalize(expanded_dec_out, dim=-1)
        ], dim=-1)

        logits_per_node = self.output_head(combined)  # shape: (B, N, num_actions)
        logits = logits_per_node.mean(dim=1)  # shape: (B, num_actions)

        # Safety clamp (optional)
        logits = torch.clamp(logits, min=-1e9, max=1e9)

        # Return both if needed
        if return_failure_pred:
            return logits, failure_prob

        return logits
