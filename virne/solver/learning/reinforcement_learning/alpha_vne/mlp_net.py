from __future__ import annotations

from typing import Optional, Tuple

import torch
import torch.nn as nn
import torch.nn.functional as F
from torch_geometric.nn import global_mean_pool

from .net import (
    ActorCriticScriptWrapper as _BaseActorCriticScriptWrapper,
    PolicyHead,
    ValueHead,
    _ActorCompat,
    _DecoderCompat,
)


class SequenceEncoder(nn.Module):
    """MLP-style VNF encoder with positional embeddings and no self-attention."""

    def __init__(self, v_net_feature_dim: int, embedding_dim: int = 128, dropout: float = 0.1, max_seq_len: int = 15):
        super().__init__()
        self.max_seq_len = max(1, int(max_seq_len))
        self.input_proj = nn.Linear(v_net_feature_dim, embedding_dim)
        self.position_embed = nn.Embedding(self.max_seq_len, embedding_dim)
        self.mlp = nn.Sequential(
            nn.Linear(embedding_dim, embedding_dim),
            nn.GELU(),
            nn.LayerNorm(embedding_dim),
            nn.Dropout(float(dropout)),
            nn.Linear(embedding_dim, embedding_dim),
            nn.GELU(),
            nn.LayerNorm(embedding_dim),
        )
        nn.init.xavier_uniform_(self.input_proj.weight)
        nn.init.zeros_(self.input_proj.bias)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        if x.dim() != 3:
            raise RuntimeError("Expected v_net_x with shape [B, T, F].")
        batch_size, seq_len, _ = x.shape
        positions = torch.arange(seq_len, device=x.device).clamp(max=self.max_seq_len - 1)
        positions = positions.unsqueeze(0).expand(batch_size, seq_len)
        return self.mlp(self.input_proj(x) + self.position_embed(positions))


class PNetEncoder(nn.Module):
    """Node-wise MLP encoder used for the MCTS+MLP neural-guide ablation."""

    def __init__(self, input_dim: int, embedding_dim: int, depth: int, dropout: float):
        super().__init__()
        depth = max(1, int(depth))
        layers = []
        in_dim = input_dim
        for _ in range(depth):
            layers.extend([
                nn.Linear(in_dim, embedding_dim),
                nn.GELU(),
                nn.LayerNorm(embedding_dim),
                nn.Dropout(float(dropout)),
            ])
            in_dim = embedding_dim
        self.net = nn.Sequential(*layers)
        for layer in self.net:
            if isinstance(layer, nn.Linear):
                nn.init.xavier_uniform_(layer.weight)
                nn.init.zeros_(layer.bias)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        return self.net(x.float())


class SharedBackbone(nn.Module):
    """MLP backbone with the same AlphaZero interfaces as transformer/gcn nets."""

    def __init__(
        self,
        p_net_num_nodes: int,
        p_net_feature_dim: int,
        embedding_dim: int = 128,
        dropout: float = 0.1,
        max_seq_len: int = 15,
        p_net_edge_dim: int = 1,
        gnn_layers: int = 3,
    ):
        super().__init__()
        del p_net_edge_dim
        self.embedding_dim = embedding_dim
        self.p_net_num_nodes = p_net_num_nodes
        self.max_seq_len = max(1, int(max_seq_len))

        self.p_encoder = PNetEncoder(
            input_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            depth=gnn_layers,
            dropout=dropout,
        )
        self.history_feature_dim = p_net_feature_dim
        self.history_embed = nn.Linear(self.history_feature_dim, embedding_dim)
        self.history_mixer = nn.Sequential(
            nn.Linear(embedding_dim, embedding_dim),
            nn.GELU(),
            nn.LayerNorm(embedding_dim),
        )
        self.step_embedding = nn.Embedding(self.max_seq_len, embedding_dim)
        self.remaining_embedding = nn.Embedding(self.max_seq_len + 1, embedding_dim)
        self.start_embedding = nn.Parameter(torch.randn(self.history_feature_dim))
        self.node_norm = nn.LayerNorm(embedding_dim)
        self.context_norm = nn.LayerNorm(embedding_dim)
        self.dropout = nn.Dropout(float(dropout))

        nn.init.xavier_uniform_(self.history_embed.weight)
        nn.init.zeros_(self.history_embed.bias)

    def _summarize_history(
        self,
        history_outputs: torch.Tensor,
        history_lengths: Optional[torch.Tensor],
    ) -> torch.Tensor:
        batch_size, seq_len, _ = history_outputs.shape
        if history_lengths is None:
            return history_outputs.mean(dim=1)
        if not isinstance(history_lengths, torch.Tensor):
            history_lengths = torch.tensor(history_lengths, device=history_outputs.device, dtype=torch.long)
        history_lengths = history_lengths.to(device=history_outputs.device, dtype=torch.long).view(-1)
        if history_lengths.numel() == 1 and batch_size > 1:
            history_lengths = history_lengths.expand(batch_size)
        history_lengths = history_lengths.clamp(min=1, max=seq_len)
        positions = torch.arange(seq_len, device=history_outputs.device).view(1, seq_len, 1)
        mask = (positions < history_lengths.view(batch_size, 1, 1)).to(dtype=history_outputs.dtype)
        totals = (history_outputs * mask).sum(dim=1)
        denom = history_lengths.to(dtype=history_outputs.dtype).view(batch_size, 1).clamp_min(1.0)
        return totals / denom

    def _forward_backbone_core(
        self,
        node_features: torch.Tensor,
        edge_index: torch.Tensor,
        edge_attr: torch.Tensor,
        node_batch: torch.Tensor,
        history_features: torch.Tensor,
        encoder_outputs: torch.Tensor,
        curr_v_node_id: torch.Tensor,
        vnfs_remaining: torch.Tensor,
        history_lengths: Optional[torch.Tensor] = None,
    ) -> Tuple[torch.Tensor, torch.Tensor, torch.Tensor, torch.Tensor]:
        del edge_index, edge_attr
        graph_embedding = self.node_norm(self.p_encoder(node_features.float()))
        graph_summary = global_mean_pool(graph_embedding, node_batch)

        history_tokens = self.dropout(F.gelu(self.history_embed(history_features)))
        history_outputs = self.history_mixer(history_tokens)
        history_summary = self._summarize_history(history_outputs, history_lengths)

        batch_size, seq_len, _ = encoder_outputs.shape
        curr_indices = curr_v_node_id.view(-1).to(dtype=torch.long).clamp(min=0, max=max(seq_len - 1, 0))
        batch_indices = torch.arange(batch_size, device=encoder_outputs.device, dtype=torch.long)
        curr_v_embeddings = encoder_outputs[batch_indices, curr_indices]

        step_emb = self.step_embedding(curr_indices.clamp(max=self.max_seq_len - 1))
        remaining_emb = self.remaining_embedding(
            vnfs_remaining.view(-1).to(dtype=torch.long).clamp(min=0, max=self.max_seq_len)
        )
        final_context = self.context_norm(
            history_summary + curr_v_embeddings + graph_summary + step_emb + remaining_emb
        )

        graph_embedding = self.node_norm(graph_embedding + graph_summary[node_batch])
        return history_outputs, graph_embedding, final_context, node_batch

    def forward_backbone(
        self,
        obs=None,
        p_net_x=None,
        p_net_edge_index=None,
        p_net_edge_attr=None,
        p_net_batch=None,
        history_features=None,
        encoder_outputs=None,
        curr_v_node_id=None,
        vnfs_remaining=None,
        history_lengths=None,
    ):
        if obs is not None:
            batch_p_net = obs["p_net"]
            node_features = batch_p_net.x.float()
            edge_index = batch_p_net.edge_index
            edge_attr = batch_p_net.edge_attr
            if hasattr(batch_p_net, "batch") and batch_p_net.batch is not None:
                node_batch = batch_p_net.batch
            else:
                node_batch = torch.zeros(batch_p_net.num_nodes, dtype=torch.long, device=batch_p_net.x.device)
            history_features = obs["history_features"]
            history_lengths = obs.get("history_lengths")
            encoder_outputs = obs["encoder_outputs"]
            curr_v_node_id = obs["curr_v_node_id"]
            vnfs_remaining = obs["vnfs_remaining"]
        else:
            node_features = p_net_x.float()
            edge_index = p_net_edge_index
            edge_attr = p_net_edge_attr
            node_batch = p_net_batch

        return self._forward_backbone_core(
            node_features=node_features,
            edge_index=edge_index,
            edge_attr=edge_attr,
            node_batch=node_batch,
            history_features=history_features,
            encoder_outputs=encoder_outputs,
            curr_v_node_id=curr_v_node_id,
            vnfs_remaining=vnfs_remaining,
            history_lengths=history_lengths,
        )

    def forward_backbone_tensors(
        self,
        p_net_x: torch.Tensor,
        p_net_edge_index: torch.Tensor,
        p_net_edge_attr: torch.Tensor,
        p_net_batch: torch.Tensor,
        history_features: torch.Tensor,
        encoder_outputs: torch.Tensor,
        curr_v_node_id: torch.Tensor,
        vnfs_remaining: torch.Tensor,
        history_lengths: Optional[torch.Tensor] = None,
    ) -> Tuple[torch.Tensor, torch.Tensor, torch.Tensor, torch.Tensor]:
        return self._forward_backbone_core(
            node_features=p_net_x.float(),
            edge_index=p_net_edge_index,
            edge_attr=p_net_edge_attr,
            node_batch=p_net_batch,
            history_features=history_features,
            encoder_outputs=encoder_outputs,
            curr_v_node_id=curr_v_node_id,
            vnfs_remaining=vnfs_remaining,
            history_lengths=history_lengths,
        )


class ActorCritic(nn.Module):
    def __init__(
        self,
        p_net_num_nodes,
        p_net_feature_dim,
        v_net_feature_dim,
        embedding_dim=128,
        n_heads=8,
        n_layers=4,
        dropout=0.1,
        p_net_edge_dim=1,
        gnn_layers=3,
        **kwargs,
    ):
        super().__init__()
        del n_layers
        max_seq_len = kwargs.get("max_seq_len", 15)
        allow_rejection = bool(kwargs.get("allow_rejection", False))

        self.encoder = SequenceEncoder(
            v_net_feature_dim=v_net_feature_dim,
            embedding_dim=embedding_dim,
            dropout=dropout,
            max_seq_len=max_seq_len,
        )
        self.backbone = SharedBackbone(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            dropout=dropout,
            max_seq_len=max_seq_len,
            p_net_edge_dim=p_net_edge_dim,
            gnn_layers=gnn_layers,
        )
        self._policy_head = PolicyHead(
            p_net_num_nodes=p_net_num_nodes,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            dropout=dropout,
            allow_rejection=allow_rejection,
        )
        self._value_head = ValueHead(
            embedding_dim=embedding_dim,
            max_seq_len=max_seq_len,
        )
        self.temperature = 1.0
        self._decoder_compat = _DecoderCompat(self.backbone, self._policy_head)
        self._actor_compat = _ActorCompat(self._decoder_compat)

    @property
    @torch.jit.unused
    def actor(self):
        return self._actor_compat

    @property
    @torch.jit.unused
    def critic(self):
        return self._value_head

    def encode(self, obs):
        return self.encoder(obs["v_net_x"])

    @torch.jit.ignore
    def act(self, obs, training=False):
        del training
        _, graph_embedding, final_context, node_batch = self.backbone.forward_backbone(obs)
        return self._policy_head(
            final_context,
            graph_embedding,
            node_batch,
            obs["action_mask"],
            self.temperature,
            obs.get("candidate_features"),
        )

    @torch.jit.ignore
    def evaluate(self, obs):
        _, graph_embedding, final_context, node_batch = self.backbone.forward_backbone(obs)
        return self._value_head(
            final_context=final_context,
            graph_embedding=graph_embedding,
            node_batch=node_batch,
            curr_v_node_id=obs.get("curr_v_node_id"),
            vnfs_remaining=obs.get("vnfs_remaining"),
            action_mask=obs.get("action_mask"),
            candidate_features=obs.get("candidate_features"),
        )

    @torch.jit.ignore
    def act_and_evaluate(self, obs, training=False):
        del training
        _, graph_embedding, final_context, node_batch = self.backbone.forward_backbone(obs)
        logits = self._policy_head(
            final_context,
            graph_embedding,
            node_batch,
            obs["action_mask"],
            self.temperature,
            obs.get("candidate_features"),
        )
        value = self._value_head(
            final_context=final_context,
            graph_embedding=graph_embedding,
            node_batch=node_batch,
            curr_v_node_id=obs.get("curr_v_node_id"),
            vnfs_remaining=obs.get("vnfs_remaining"),
            action_mask=obs.get("action_mask"),
            candidate_features=obs.get("candidate_features"),
        )
        return logits, value

    def load_state_dict(self, state_dict, strict: bool = True):
        if isinstance(state_dict, dict) and "model" in state_dict and isinstance(state_dict["model"], dict):
            state_dict = state_dict["model"]
        return super().load_state_dict(state_dict, strict=strict)


class ActorCriticScriptWrapper(_BaseActorCriticScriptWrapper):
    pass
