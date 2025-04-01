import torch
import torch.nn as nn
import torch.nn.functional as F
from torch_geometric.nn import GATConv

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

        nn.init.xavier_uniform_(self.gat.lin.weight, gain=1.43)
        nn.init.zeros_(self.gat.bias)
        nn.init.xavier_uniform_(self.skip.weight, gain=1.0)

    def forward(self, x, edge_index):
        x = x.to(edge_index.device)
        gat_out = self.gat(x, edge_index)
        skip_out = self.skip(x)
        out = self.norm(gat_out + 0.1 * skip_out)
        out = F.elu(out)
        out = self.dropout(out)
        return out


class ActorCritic(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, v_net_feature_dim,
                 embedding_dim=128, n_heads=8, n_layers=6, dropout=0.2, **kwargs):
        super().__init__()
        self.encoder = Encoder(
            v_net_feature_dim,  # <-- update based on v_net_x shape (usually 2)
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout
        )
        self.actor = PlacementPredictor(
            p_net_num_nodes,
            p_net_feature_dim,
            embedding_dim=embedding_dim,
            dropout=dropout,
            allow_revocable=kwargs.get("allow_revocable", False),
            allow_rejection=kwargs.get("allow_rejection", False)
        )
        self.critic = ValueEstimator(embedding_dim=embedding_dim)

    def encode(self, obs):
        return self.encoder(obs['v_net_x'])

    def act(self, obs):
        return self.actor(obs)

    def evaluate(self, obs):
        return self.critic(obs)


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
            activation='gelu'
        )
        self.transformer_encoder = nn.TransformerEncoder(encoder_layer, num_layers=n_layers)
        self.norm = nn.LayerNorm(embedding_dim)
        nn.init.xavier_uniform_(self.emb.weight, gain=1.0)

    def forward(self, x):
        if x.dim() == 2:
            x = x.unsqueeze(0)
        x = self.emb(x)
        x = self.transformer_encoder(x)
        return self.norm(x)


class PlacementPredictor(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128, dropout=0.2,
                 allow_revocable=False, allow_rejection=False):
        super().__init__()
        self.num_actions = p_net_num_nodes + int(allow_revocable) + int(allow_rejection)

        self.gat_layers = nn.ModuleList([
            MultiHeadGATSkipLayer(p_net_feature_dim if i == 0 else embedding_dim * 8, embedding_dim, heads=8, dropout=dropout)
            for i in range(3)
        ])
        self.gat_proj = nn.Linear(embedding_dim * 8, embedding_dim)
        self.output_head = nn.Sequential(
            nn.Linear(2 * embedding_dim, embedding_dim),
            nn.GELU(),
            nn.Linear(embedding_dim, self.num_actions)
        )

    def forward(self, obs):
        p_net = obs['p_net']
        x, edge_index = p_net.x, p_net.edge_index
        for gat in self.gat_layers:
            x = gat(x, edge_index)
        graph_emb = self.gat_proj(x)
        graph_emb = graph_emb.reshape(p_net.num_graphs, -1, graph_emb.shape[-1]).mean(dim=1)

        encoder_outputs = obs['encoder_outputs'].mean(dim=1)
        combined = torch.cat([F.normalize(graph_emb, dim=-1), F.normalize(encoder_outputs, dim=-1)], dim=-1)
        return self.output_head(combined)


class ValueEstimator(nn.Module):
    def __init__(self, embedding_dim=128):
        super().__init__()
        self.value_head = nn.Sequential(
            nn.Linear(embedding_dim, embedding_dim // 2),
            nn.GELU(),
            nn.Linear(embedding_dim // 2, 1)
        )

    def forward(self, obs):
        encoder_outputs = obs['encoder_outputs'].mean(dim=1)
        return self.value_head(encoder_outputs)
