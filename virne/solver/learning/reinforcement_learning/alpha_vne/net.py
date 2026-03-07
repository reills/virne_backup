# ==============================================================================
# net.py  (Unified Actor-Critic with Shared Backbone)
# ==============================================================================
from typing import Dict, Optional, Tuple

import torch
import torch.nn as nn
import torch.nn.functional as F
from torch_geometric.nn import GENConv
from torch_geometric.utils import scatter
from torch_geometric.nn import global_mean_pool


class MultiHeadGENLayer(nn.Module):
    def __init__(self, in_dim, out_dim, aggr='softmax', edge_dim=1, gnn_dropout: float = 0.1):
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
        self.dropout = nn.Dropout(float(gnn_dropout))
        self.edge_mlp = nn.Sequential(
            nn.Linear(2 * out_dim, out_dim),
            nn.GELU(),
            nn.LayerNorm(out_dim)
        )

    def forward(self, x, edge_index, edge_attr):
        out_x = self.conv(x, edge_index, edge_attr)
        out_x = self.norm(out_x)
        out_x = F.elu(out_x)
        out_x = self.dropout(out_x)

        row = edge_index[0]
        col = edge_index[1]
        edge_feat = torch.cat([out_x[row], out_x[col]], dim=1)
        out_e = self.edge_mlp(edge_feat)

        return out_x, out_e


# --- Encoder Module ---
class Encoder(nn.Module):
    def __init__(self, v_net_feature_dim, embedding_dim=128, n_heads=8, n_layers=4, dropout=0.1, max_seq_len=15):
        super().__init__()

        self.token_embed = nn.Linear(v_net_feature_dim, embedding_dim)
        self.position_embed = nn.Embedding(max_seq_len, embedding_dim)

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
        nn.init.xavier_uniform_(self.token_embed.weight, gain=1.0)
        for layer in self.transformer_encoder.layers:
            nn.init.xavier_uniform_(layer.linear1.weight, gain=1.43)
            nn.init.zeros_(layer.linear1.bias)
            nn.init.xavier_uniform_(layer.linear2.weight, gain=1.0)
            nn.init.zeros_(layer.linear2.bias)

    def forward(self, x):  # x: [B, T, F]
        B, T, _ = x.size()
        positions = torch.arange(T, device=x.device).unsqueeze(0).expand(B, T)
        x = self.token_embed(x) + self.position_embed(positions)
        x = self.transformer_encoder(x)
        return self.norm(x)


# --- Shared Backbone (GNN + Transformer Decoder) ---
class SharedBackbone(nn.Module):
    """Shared GNN encoder and Transformer decoder used by both policy and value heads."""

    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128,
                 n_heads=8, n_layers=4, dropout=0.1, gnn_dropout=0.1, max_seq_len=15,
                 p_net_edge_dim=1, gnn_layers=3):
        super().__init__()
        self.embedding_dim = embedding_dim
        self.p_net_num_nodes = p_net_num_nodes

        # Step / remaining embeddings
        self.step_embedding = nn.Embedding(max_seq_len, embedding_dim)
        self.remaining_embedding = nn.Embedding(max_seq_len + 1, embedding_dim)

        # Physical network encoder (GNN layers)
        self.gat_layers = nn.ModuleList([
            MultiHeadGENLayer(
                in_dim=p_net_feature_dim if i == 0 else embedding_dim,
                out_dim=embedding_dim,
                edge_dim=p_net_edge_dim if i == 0 else embedding_dim,
                gnn_dropout=gnn_dropout,
            )
            for i in range(gnn_layers)
        ])
        self.gat_projection = nn.Identity()

        # Transformer decoder for sequence processing
        decoder_layer = nn.TransformerDecoderLayer(
            d_model=embedding_dim, nhead=n_heads,
            dim_feedforward=4 * embedding_dim, dropout=dropout,
            batch_first=True, activation='gelu'
        )
        self.transformer_decoder = nn.TransformerDecoder(decoder_layer, num_layers=n_layers)
        self.norm = nn.LayerNorm(embedding_dim)

        # History embeddings
        self.history_feature_dim = p_net_feature_dim
        self.history_embed = nn.Linear(self.history_feature_dim, self.embedding_dim)

        # Learnable start embedding
        self.start_embedding = nn.Parameter(torch.randn(self.history_feature_dim))

        # Initialization
        nn.init.xavier_uniform_(self.history_embed.weight)
        nn.init.zeros_(self.history_embed.bias)

    def _build_history_padding_mask(self, history_features: torch.Tensor, history_lengths: Optional[torch.Tensor] = None) -> torch.Tensor:
        """Build decoder padding mask from explicit history lengths.

        Falls back to legacy zero-vector detection when lengths are unavailable.
        """
        if history_lengths is None:
            return torch.all(history_features == 0, dim=-1)

        if not isinstance(history_lengths, torch.Tensor):
            history_lengths = torch.tensor(history_lengths, dtype=torch.long, device=history_features.device)
        else:
            history_lengths = history_lengths.to(device=history_features.device, dtype=torch.long)

        if history_lengths.dim() == 0:
            history_lengths = history_lengths.unsqueeze(0)
        history_lengths = history_lengths.view(-1)

        batch_size = history_features.size(0)
        if history_lengths.numel() == 1 and batch_size > 1:
            history_lengths = history_lengths.expand(batch_size)
        elif history_lengths.numel() != batch_size:
            return torch.all(history_features == 0, dim=-1)

        seq_len = history_features.size(1)
        history_lengths = history_lengths.clamp(min=1, max=seq_len)
        positions = torch.arange(seq_len, device=history_features.device).unsqueeze(0)
        return positions >= history_lengths.unsqueeze(1)

    def forward_backbone(self, obs=None, *,
                         p_net_x=None, p_net_edge_index=None, p_net_edge_attr=None,
                         p_net_batch=None, history_features=None, encoder_outputs=None,
                         curr_v_node_id=None, vnfs_remaining=None, history_lengths=None):
        """Run GNN + Transformer decoder, return (decoder_output, graph_embedding, final_context).

        Can be called with an obs dict (PyG path) or raw tensors (TorchScript path).
        """
        if obs is not None:
            batch_p_net = obs['p_net']
            node_features = batch_p_net.x.float()
            edge_index = batch_p_net.edge_index
            edge_attr = batch_p_net.edge_attr
            if hasattr(batch_p_net, 'batch') and batch_p_net.batch is not None:
                node_batch = batch_p_net.batch
            else:
                node_batch = torch.zeros(batch_p_net.num_nodes, dtype=torch.long, device=batch_p_net.x.device)
            history_features = obs['history_features']
            history_lengths = obs.get('history_lengths')
            encoder_outputs = obs['encoder_outputs']
            curr_v_node_id = obs['curr_v_node_id']
            vnfs_remaining = obs['vnfs_remaining']
        else:
            node_features = p_net_x.float()
            edge_index = p_net_edge_index
            edge_attr = p_net_edge_attr
            node_batch = p_net_batch

        # GNN forward
        for gat_layer in self.gat_layers:
            node_features, edge_attr = gat_layer(node_features, edge_index, edge_attr)
        graph_embedding = self.gat_projection(node_features)

        # Embed history
        action_embeddings = self.history_embed(history_features)
        combined_target = action_embeddings

        # Transformer decoder
        batch_size, seq_len, _ = combined_target.shape
        causal_mask = torch.triu(
            torch.ones(seq_len, seq_len, device=combined_target.device), diagonal=1
        ).to(dtype=torch.bool)
        padding_mask = self._build_history_padding_mask(
            history_features=history_features,
            history_lengths=history_lengths,
        )

        decoder_output = self.transformer_decoder(
            tgt=combined_target,
            memory=encoder_outputs,
            tgt_mask=causal_mask,
            tgt_key_padding_mask=padding_mask
        )

        # Final context from last decoder position
        last_decoder_output = decoder_output[:, -1, :]
        step_emb = self.step_embedding(curr_v_node_id)
        remaining_emb = self.remaining_embedding(vnfs_remaining)
        final_context = self.norm(last_decoder_output + step_emb + remaining_emb)

        return decoder_output, graph_embedding, final_context, node_batch


# --- Compatibility shim for policy.actor.decoder.* access patterns ---
class _DecoderCompat:
    """Exposes backbone/head attributes under the legacy .decoder namespace."""
    def __init__(self, backbone: SharedBackbone, policy_head: 'PolicyHead'):
        self._backbone = backbone
        self._policy_head = policy_head

    @property
    def start_embedding(self):
        return self._backbone.start_embedding

    @property
    def num_actions(self):
        return self._policy_head.num_actions

    @property
    def allow_rejection(self):
        return self._policy_head.allow_rejection

    @property
    def embedding_dim(self):
        return self._backbone.embedding_dim

    @property
    def temperature(self):
        return getattr(self._policy_head, '_temperature', 1.0)

    @temperature.setter
    def temperature(self, val):
        self._policy_head._temperature = val


class _ActorCompat:
    """Shim so that model.actor.decoder.X still works."""
    def __init__(self, decoder_compat: _DecoderCompat):
        self.decoder = decoder_compat


# --- Unified ActorCritic Model ---
class ActorCritic(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, v_net_feature_dim,
                 embedding_dim=128, n_heads=8, n_layers=4, dropout=0.1,
                 p_net_edge_dim=1, gnn_layers=3, **kwargs):
        super().__init__()

        max_seq_len = kwargs.get("max_seq_len", 15)
        allow_rejection = bool(kwargs.get("allow_rejection", False))
        gnn_dropout = float(kwargs.get("gnn_dropout", 0.1))

        self.encoder = Encoder(v_net_feature_dim, embedding_dim, n_heads, n_layers, dropout, max_seq_len=max_seq_len)

        # Shared backbone (GNN + Transformer decoder)
        self.backbone = SharedBackbone(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout,
            gnn_dropout=gnn_dropout,
            max_seq_len=max_seq_len,
            p_net_edge_dim=p_net_edge_dim,
            gnn_layers=gnn_layers,
        )

        # Lightweight policy head (registered as _policy_head to avoid name clash with compat .actor)
        self._policy_head = PolicyHead(
            p_net_num_nodes=p_net_num_nodes,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            dropout=dropout,
            allow_rejection=allow_rejection,
        )

        # Lightweight value head (registered as _value_head to avoid name clash with compat .critic)
        self._value_head = ValueHead(
            embedding_dim=embedding_dim,
            max_seq_len=max_seq_len,
        )

        # Temperature for actor logit scaling
        self.temperature = 1.0

        # Backward-compatibility shim: many call-sites access
        # policy.actor.decoder.{start_embedding, num_actions, allow_rejection, ...}
        self._decoder_compat = _DecoderCompat(self.backbone, self._policy_head)
        self._actor_compat = _ActorCompat(self._decoder_compat)

    @property
    def actor(self):
        """Backward-compatible: returns shim with .decoder attribute."""
        return self._actor_compat

    @property
    def critic(self):
        """Backward-compatible: returns the value head module."""
        return self._value_head

    def encode(self, obs):
        return self.encoder(obs['v_net_x'])

    @torch.jit.ignore
    def act(self, obs, training=False):
        """Run shared backbone once and return policy logits."""
        decoder_output, graph_embedding, final_context, node_batch = self.backbone.forward_backbone(obs)
        return self._policy_head(final_context, graph_embedding, node_batch, obs['action_mask'], self.temperature)

    @torch.jit.ignore
    def evaluate(self, obs):
        """Run shared backbone once and return value estimate."""
        decoder_output, graph_embedding, final_context, node_batch = self.backbone.forward_backbone(obs)
        return self._value_head(
            final_context=final_context,
            graph_embedding=graph_embedding,
            node_batch=node_batch,
            curr_v_node_id=obs.get('curr_v_node_id'),
            vnfs_remaining=obs.get('vnfs_remaining'),
            action_mask=obs.get('action_mask'),
        )

    @torch.jit.ignore
    def act_and_evaluate(self, obs, training=False):
        """Run shared backbone ONCE and return both logits and value."""
        decoder_output, graph_embedding, final_context, node_batch = self.backbone.forward_backbone(obs)
        logits = self._policy_head(final_context, graph_embedding, node_batch, obs['action_mask'], self.temperature)
        value = self._value_head(
            final_context=final_context,
            graph_embedding=graph_embedding,
            node_batch=node_batch,
            curr_v_node_id=obs.get('curr_v_node_id'),
            vnfs_remaining=obs.get('vnfs_remaining'),
            action_mask=obs.get('action_mask'),
        )
        return logits, value

    def _remap_legacy_state_dict(self, state_dict: Dict[str, torch.Tensor]) -> Dict[str, torch.Tensor]:
        """Map split actor/critic checkpoints into the shared-backbone layout."""
        target_state = self.state_dict()
        remapped: Dict[str, torch.Tensor] = {}

        def _put(dst_key: str, value: torch.Tensor) -> None:
            if dst_key not in target_state:
                return
            if target_state[dst_key].shape != value.shape:
                return
            remapped.setdefault(dst_key, value)

        for key, value in state_dict.items():
            if key in target_state:
                _put(key, value)
                continue

            mapped_key = None
            if key.startswith("actor.decoder.node_cross_attention."):
                mapped_key = key.replace("actor.decoder.node_cross_attention.", "_policy_head.node_cross_attention.", 1)
            elif key.startswith("actor.decoder.node_score_head."):
                mapped_key = key.replace("actor.decoder.node_score_head.", "_policy_head.node_score_head.", 1)
            elif key.startswith("actor.decoder.reject_head."):
                mapped_key = key.replace("actor.decoder.reject_head.", "_policy_head.reject_head.", 1)
            elif key.startswith("actor.decoder."):
                mapped_key = key.replace("actor.decoder.", "backbone.", 1)
            elif key.startswith("critic.decoder."):
                mapped_key = key.replace("critic.decoder.", "backbone.", 1)
            elif key.startswith("critic.value_head."):
                mapped_key = key.replace("critic.value_head.", "_value_head.value_head.", 1)

            if mapped_key is not None:
                _put(mapped_key, value)

        return remapped

    def load_state_dict(self, state_dict, strict: bool = True):
        """Load checkpoints with backward compatibility for legacy split models."""
        if isinstance(state_dict, dict) and "model" in state_dict and isinstance(state_dict["model"], dict):
            state_dict = state_dict["model"]

        try:
            return super().load_state_dict(state_dict, strict=strict)
        except RuntimeError:
            remapped = self._remap_legacy_state_dict(state_dict)
            return super().load_state_dict(remapped, strict=False)


# --- Policy Head ---
class PolicyHead(nn.Module):
    """Lightweight policy head that operates on shared backbone outputs."""

    def __init__(self, p_net_num_nodes, embedding_dim=128, n_heads=8, dropout=0.1,
                 allow_rejection=False):
        super().__init__()
        self.p_net_num_nodes = p_net_num_nodes
        self.allow_rejection = allow_rejection
        self.num_actions = p_net_num_nodes + (1 if allow_rejection else 0)
        self.embedding_dim = embedding_dim

        # Cross-attention between decoder output and node embeddings
        self.node_cross_attention = nn.MultiheadAttention(
            embed_dim=embedding_dim, num_heads=n_heads,
            dropout=dropout, batch_first=False
        )

        # Predict 1 score per physical node
        self.node_score_head = nn.Sequential(
            nn.Linear(2 * embedding_dim, embedding_dim),
            nn.GELU(),
            nn.Linear(embedding_dim, 1)
        )

        # Optional special-action head for REJECT
        self.reject_head: Optional[nn.Module] = None
        if self.allow_rejection:
            self.reject_head = nn.Sequential(
                nn.Linear(embedding_dim, embedding_dim // 2),
                nn.GELU(),
                nn.Linear(embedding_dim // 2, 1)
            )

        # Initialization
        for layer in self.node_score_head:
            if isinstance(layer, nn.Linear):
                nn.init.xavier_uniform_(layer.weight)
                nn.init.zeros_(layer.bias)
        if self.allow_rejection and self.reject_head is not None:
            for layer in self.reject_head:
                if isinstance(layer, nn.Linear):
                    nn.init.xavier_uniform_(layer.weight)
                    nn.init.zeros_(layer.bias)

    def forward(self, final_context, graph_embedding, node_batch, action_mask, temperature=1.0):
        """Compute policy logits from shared backbone outputs.

        Args:
            final_context: [B, D] from backbone
            graph_embedding: [N_total, D] from backbone GNN
            node_batch: [N_total] batch index per node
            action_mask: [B, num_actions] boolean mask
            temperature: logit temperature scaling
        """
        B = final_context.size(0)

        # Cross-attend to nodes
        nodes_per_graph = scatter(torch.ones_like(node_batch), node_batch, dim=0, reduce='sum').long()
        max_nodes = nodes_per_graph.max().item()
        padded_nodes = torch.zeros(B, max_nodes, self.embedding_dim, device=graph_embedding.device)
        node_padding_mask = torch.ones(B, max_nodes, dtype=torch.bool, device=graph_embedding.device)

        for i in range(B):
            idxs = (node_batch == i).nonzero(as_tuple=True)[0]
            padded_nodes[i, :len(idxs)] = graph_embedding[idxs]
            node_padding_mask[i, :len(idxs)] = False

        query = final_context.unsqueeze(0)
        key = value = padded_nodes.transpose(0, 1)
        attn_output, _ = self.node_cross_attention(query=query, key=key, value=value, key_padding_mask=node_padding_mask)
        attn_context = attn_output.squeeze(0)
        attn_context_per_node = attn_context[node_batch]

        # Compute node scores
        combined = torch.cat([
            F.normalize(graph_embedding, dim=-1, eps=1e-6),
            F.normalize(attn_context_per_node, dim=-1, eps=1e-6),
        ], dim=-1)
        node_scores = self.node_score_head(combined).squeeze(-1)

        # Assemble final logits for physical nodes
        raw_logits_nodes = torch.full((B, self.p_net_num_nodes), -20.0, device=node_scores.device, dtype=node_scores.dtype)

        current_node_idx = 0
        for i in range(B):
            num_nodes = nodes_per_graph[i].item()
            nodes_to_consider = min(num_nodes, self.num_actions)
            if nodes_to_consider > 0:
                raw_logits_nodes[i, :nodes_to_consider] = node_scores[current_node_idx:current_node_idx + nodes_to_consider]
            current_node_idx += num_nodes

        # Optional REJECT logit
        if self.allow_rejection and self.reject_head is not None:
            reject_logit = self.reject_head(final_context)
            raw_logits = torch.cat([raw_logits_nodes, reject_logit], dim=-1)
        else:
            raw_logits = raw_logits_nodes

        # Apply action mask and clamp
        safe_logits = torch.clamp(raw_logits, min=-15.0, max=15.0)
        mask = action_mask.bool()
        neg_large = torch.full_like(safe_logits, -1e9)
        final_logits = torch.where(mask, safe_logits, neg_large)

        if temperature != 1.0:
            final_logits = final_logits.clone()
            final_logits[mask] = final_logits[mask] / temperature

        return final_logits


# --- Value Head ---
class ValueHead(nn.Module):
    """Lightweight value head that operates on shared backbone outputs."""

    def __init__(self, embedding_dim=128, max_seq_len=15):
        super().__init__()
        self.max_seq_len = max(int(max_seq_len), 1)
        combined_dim = embedding_dim + embedding_dim + 3
        self.value_head = nn.Sequential(
            nn.Linear(combined_dim, embedding_dim),
            nn.GELU(),
            nn.LayerNorm(embedding_dim),
            nn.Linear(embedding_dim, embedding_dim // 2),
            nn.GELU(),
            nn.Linear(embedding_dim // 2, 1),
        )

    def forward(
        self,
        final_context,
        graph_embedding,
        node_batch,
        curr_v_node_id=None,
        vnfs_remaining=None,
        action_mask=None,
    ):
        """Compute value from shared backbone outputs.

        Args:
            final_context: [B, D] decision-context embedding from final decoder state
            graph_embedding: [N_total, D] from backbone GNN
            node_batch: [N_total] batch index per node
        """
        batch_size = final_context.size(0)
        graph_summary = global_mean_pool(graph_embedding, node_batch)  # [B, D]

        # Lightweight scalar features for decision relevance:
        # step progress, remaining VNFs, and feasible-action ratio.
        if curr_v_node_id is None:
            step_feat = torch.zeros((batch_size, 1), dtype=final_context.dtype, device=final_context.device)
        else:
            step_feat = curr_v_node_id.float().view(batch_size, -1)[:, :1]
            step_feat = step_feat / float(self.max_seq_len)

        if vnfs_remaining is None:
            remaining_feat = torch.zeros((batch_size, 1), dtype=final_context.dtype, device=final_context.device)
        else:
            remaining_feat = vnfs_remaining.float().view(batch_size, -1)[:, :1]
            remaining_feat = remaining_feat / float(self.max_seq_len)

        if action_mask is None:
            feasible_ratio = torch.zeros((batch_size, 1), dtype=final_context.dtype, device=final_context.device)
        else:
            mask = action_mask.to(dtype=final_context.dtype)
            if mask.dim() == 1:
                mask = mask.unsqueeze(0)
            feasible_ratio = mask.mean(dim=-1, keepdim=True)

        scalar_feats = torch.cat([step_feat, remaining_feat, feasible_ratio], dim=-1)
        combined = torch.cat([final_context, graph_summary, scalar_feats], dim=-1)
        return self.value_head(combined)


# --- Legacy Wrapper: AutoregressiveDecoder ---
# Kept for backward compatibility with PolicyNetwork, NodeExpander, and C++ inference.
# Delegates to SharedBackbone + PolicyHead internally.
class AutoregressiveDecoder(nn.Module):
    """Wrapper that presents the old AutoregressiveDecoder interface
    but delegates to a SharedBackbone and PolicyHead internally."""

    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128,
                 n_heads=8, n_layers=4, dropout=0.1, gnn_dropout=0.1, is_actor=True,
                 allow_revocable=False, allow_rejection=False, use_amp=False, max_seq_len=15,
                 p_net_edge_dim=1, gnn_layers=3):
        super().__init__()
        self.embedding_dim = embedding_dim
        self.use_amp = use_amp
        self.p_net_num_nodes = p_net_num_nodes
        self.allow_rejection = bool(allow_rejection)
        self.temperature = 1.0
        self.is_actor = is_actor

        self.num_actions = p_net_num_nodes + (1 if self.allow_rejection else 0)
        self.start_token = self.num_actions
        self.pad_token = self.num_actions + 1

        # Own backbone and heads (used during standalone inference e.g. C++ path)
        self._backbone = SharedBackbone(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout,
            gnn_dropout=gnn_dropout,
            max_seq_len=max_seq_len,
            p_net_edge_dim=p_net_edge_dim,
            gnn_layers=gnn_layers,
        )

        # Expose sub-modules that external code references
        self.history_embed = self._backbone.history_embed
        self.start_embedding = self._backbone.start_embedding
        self.step_embedding = self._backbone.step_embedding
        self.remaining_embedding = self._backbone.remaining_embedding
        self.gat_layers = self._backbone.gat_layers
        self.gat_projection = self._backbone.gat_projection
        self.transformer_decoder = self._backbone.transformer_decoder
        self.norm = self._backbone.norm

        if is_actor:
            self._policy_head = PolicyHead(
                p_net_num_nodes=p_net_num_nodes,
                embedding_dim=embedding_dim,
                n_heads=n_heads,
                dropout=dropout,
                allow_rejection=allow_rejection,
            )
            # Expose for external code
            self.node_cross_attention = self._policy_head.node_cross_attention
            self.node_score_head = self._policy_head.node_score_head
            self.reject_head = self._policy_head.reject_head

    @torch.jit.ignore
    def forward(self, obs, return_last_embed=False, return_all_embeds=False, return_gat_embedding=False, training=False):
        decoder_output, graph_embedding, final_context, node_batch = self._backbone.forward_backbone(obs)

        if return_all_embeds and return_gat_embedding:
            return decoder_output, graph_embedding
        elif return_all_embeds:
            return decoder_output

        if return_last_embed or not self.is_actor:
            return final_context

        return self._policy_head(final_context, graph_embedding, node_batch, obs['action_mask'], self.temperature)

    def embeddings_from_tensors(
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
    ) -> Tuple[torch.Tensor, torch.Tensor]:
        """Return decoder and graph embeddings from raw tensors."""
        decoder_output, graph_embedding, final_context, node_batch = self._backbone.forward_backbone(
            obs=None,
            p_net_x=p_net_x, p_net_edge_index=p_net_edge_index,
            p_net_edge_attr=p_net_edge_attr, p_net_batch=p_net_batch,
            history_features=history_features, encoder_outputs=encoder_outputs,
            curr_v_node_id=curr_v_node_id, vnfs_remaining=vnfs_remaining,
            history_lengths=history_lengths,
        )
        return decoder_output, graph_embedding

    def forward_from_tensors(
        self,
        p_net_x: torch.Tensor,
        p_net_edge_index: torch.Tensor,
        p_net_edge_attr: torch.Tensor,
        p_net_batch: torch.Tensor,
        history_features: torch.Tensor,
        encoder_outputs: torch.Tensor,
        curr_v_node_id: torch.Tensor,
        vnfs_remaining: torch.Tensor,
        action_mask: torch.Tensor,
        history_lengths: Optional[torch.Tensor] = None,
        return_last_embed: bool = False,
    ) -> torch.Tensor:
        """TorchScript-friendly forward that accepts raw tensors."""
        decoder_output, graph_embedding, final_context, node_batch = self._backbone.forward_backbone(
            obs=None,
            p_net_x=p_net_x, p_net_edge_index=p_net_edge_index,
            p_net_edge_attr=p_net_edge_attr, p_net_batch=p_net_batch,
            history_features=history_features, encoder_outputs=encoder_outputs,
            curr_v_node_id=curr_v_node_id, vnfs_remaining=vnfs_remaining,
            history_lengths=history_lengths,
        )

        if return_last_embed or not self.is_actor:
            return final_context

        batch_size = history_features.size(0)
        node_batch_t = p_net_batch
        if batch_size > 1:
            num_nodes = graph_embedding.size(0) // batch_size
            graph_embedding_r = graph_embedding.view(batch_size, num_nodes, -1)
            node_padding_mask = torch.zeros((batch_size, num_nodes), dtype=torch.bool, device=graph_embedding.device)
            query = final_context.unsqueeze(0)
            key = value = graph_embedding_r.transpose(0, 1)
            attn_output, _ = self._policy_head.node_cross_attention(query=query, key=key, value=value, key_padding_mask=node_padding_mask)
            attn_context = attn_output.squeeze(0)
            attn_context_per_node = attn_context.index_select(0, node_batch_t)
            graph_embedding_flat = graph_embedding_r.reshape(batch_size * num_nodes, -1)
        else:
            padded_nodes = graph_embedding.unsqueeze(0)
            node_padding_mask = torch.zeros((1, graph_embedding.size(0)), dtype=torch.bool, device=graph_embedding.device)
            query = final_context.unsqueeze(0)
            key = value = padded_nodes.transpose(0, 1)
            attn_output, _ = self._policy_head.node_cross_attention(query=query, key=key, value=value, key_padding_mask=node_padding_mask)
            attn_context = attn_output.squeeze(0)
            attn_context_per_node = attn_context.index_select(0, node_batch_t)
            graph_embedding_flat = graph_embedding

        combined = torch.cat([
            F.normalize(graph_embedding_flat, dim=-1, eps=1e-6),
            F.normalize(attn_context_per_node, dim=-1, eps=1e-6),
        ], dim=-1)
        node_scores = self._policy_head.node_score_head(combined).squeeze(-1)

        raw_logits_nodes = torch.full(
            (batch_size, self.p_net_num_nodes), -20.0, device=node_scores.device, dtype=node_scores.dtype
        )
        nodes_to_consider = node_scores.view(batch_size, -1)
        nodes_to_consider = nodes_to_consider[:, : self.p_net_num_nodes]
        raw_logits_nodes[:, : nodes_to_consider.size(1)] = nodes_to_consider

        if self.is_actor and self.allow_rejection and self._policy_head.reject_head is not None:
            reject_logit = self._policy_head.reject_head(final_context)
            raw_logits = torch.cat([raw_logits_nodes, reject_logit], dim=-1)
        else:
            raw_logits = raw_logits_nodes

        safe_logits = torch.clamp(raw_logits, min=-15.0, max=15.0)
        mask = action_mask.to(dtype=torch.bool)
        neg_large = torch.full_like(safe_logits, -1e9)
        final_logits = torch.where(mask, safe_logits, neg_large)

        T = self.temperature
        if T != 1.0:
            final_logits = final_logits.clone()
            final_logits[mask] = final_logits[mask] / T

        return final_logits


# --- Legacy Actor/Critic wrappers for backward compatibility ---
class Actor(nn.Module):
    """Thin wrapper preserving the old Actor interface."""
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128,
                 n_heads=8, n_layers=4, dropout=0.1, gnn_layers=3, **kwargs):
        super().__init__()
        p_net_edge_dim = kwargs.pop('p_net_edge_dim', 1)
        self.decoder = AutoregressiveDecoder(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout,
            is_actor=True,
            p_net_edge_dim=p_net_edge_dim,
            gnn_layers=gnn_layers,
            **kwargs
        )

    @torch.jit.ignore
    def forward(self, obs, training=False):
        return self.decoder(obs, training=training)


class Critic(nn.Module):
    """Thin wrapper preserving the old Critic interface."""
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128,
                 n_heads=8, n_layers=4, dropout=0.1, gnn_layers=3, **kwargs):
        super().__init__()
        self.p_net_feature_dim = p_net_feature_dim
        self.embedding_dim = embedding_dim
        self.decoder = AutoregressiveDecoder(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout,
            is_actor=False,
            gnn_layers=gnn_layers,
            **kwargs
        )
        combined_dim = embedding_dim + embedding_dim
        self.value_head = nn.Sequential(
            nn.Linear(combined_dim, embedding_dim // 2),
            nn.GELU(),
            nn.Linear(embedding_dim // 2, 1)
        )

    @torch.jit.ignore
    def forward(self, obs):
        decoder_outputs, graph_embedding = self.decoder(
            obs, return_all_embeds=True, return_gat_embedding=True, training=False
        )
        seq_summary = decoder_outputs.mean(dim=1)
        node_batch = obs['p_net'].batch
        graph_summary = global_mean_pool(graph_embedding, node_batch)
        combined = torch.cat([seq_summary, graph_summary], dim=-1)
        return self.value_head(combined)

    def forward_from_tensors(
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
    ) -> torch.Tensor:
        decoder_outputs, graph_embedding = self.decoder.embeddings_from_tensors(
            p_net_x=p_net_x,
            p_net_edge_index=p_net_edge_index,
            p_net_edge_attr=p_net_edge_attr,
            p_net_batch=p_net_batch,
            history_features=history_features,
            encoder_outputs=encoder_outputs,
            curr_v_node_id=curr_v_node_id,
            vnfs_remaining=vnfs_remaining,
            history_lengths=history_lengths,
        )
        seq_summary = decoder_outputs.mean(dim=1)
        batch_size = history_features.size(0)
        if batch_size > 1:
            num_nodes = graph_embedding.size(0) // batch_size
            graph_summary = graph_embedding.view(batch_size, num_nodes, -1).mean(dim=1)
        else:
            graph_summary = graph_embedding.mean(dim=0, keepdim=True)
        combined = torch.cat([seq_summary, graph_summary], dim=-1)
        return self.value_head(combined)


class ActorCriticScriptWrapper(nn.Module):
    """TorchScript-friendly wrapper around ActorCritic for C++ inference."""

    def __init__(self, model: ActorCritic):
        super().__init__()
        self.model = model

    @torch.jit.export
    def encode(self, v_net_x: torch.Tensor) -> torch.Tensor:
        return self.model.encoder(v_net_x)

    @torch.jit.export
    def get_start_embedding(self) -> torch.Tensor:
        return self.model.backbone.start_embedding

    def forward(self, inputs: Dict[str, torch.Tensor]) -> Tuple[torch.Tensor, torch.Tensor]:
        """Compute policy logits and value from tensor inputs."""
        p_net_x = inputs["p_net_x"]
        p_net_edge_index = inputs["p_net_edge_index"]
        p_net_edge_attr = inputs["p_net_edge_attr"]
        p_net_batch = inputs["p_net_batch"]
        selected_p_nodes = inputs["selected_p_nodes"]
        encoder_outputs = inputs["encoder_outputs"]
        curr_v_node_id = inputs["curr_v_node_id"]
        vnfs_remaining = inputs["vnfs_remaining"]
        action_mask = inputs["action_mask"]
        history_lengths = inputs["history_lengths"] if "history_lengths" in inputs else None

        if "history_features" in inputs:
            history_features = inputs["history_features"]
        else:
            history_len = selected_p_nodes.size(0) + 1
            history_features = torch.zeros(
                (1, history_len, p_net_x.size(1)),
                device=p_net_x.device,
                dtype=p_net_x.dtype,
            )
            history_features[0, 0, :] = self.model.backbone.start_embedding.to(p_net_x.dtype)
            if selected_p_nodes.numel() > 0:
                gathered = torch.index_select(p_net_x, 0, selected_p_nodes)
                history_features[0, 1:history_len, :] = gathered
            history_lengths = torch.tensor([history_len], dtype=torch.long, device=p_net_x.device)

        # Run shared backbone once
        decoder_output, graph_embedding, final_context, node_batch = self.model.backbone.forward_backbone(
            obs=None,
            p_net_x=p_net_x,
            p_net_edge_index=p_net_edge_index,
            p_net_edge_attr=p_net_edge_attr,
            p_net_batch=p_net_batch,
            history_features=history_features,
            encoder_outputs=encoder_outputs,
            curr_v_node_id=curr_v_node_id,
            vnfs_remaining=vnfs_remaining,
            history_lengths=history_lengths,
        )

        # Policy logits
        logits = self.model._policy_head(final_context, graph_embedding, node_batch, action_mask, self.model.temperature)

        # Value
        value = self.model._value_head(
            final_context=final_context,
            graph_embedding=graph_embedding,
            node_batch=node_batch,
            curr_v_node_id=curr_v_node_id,
            vnfs_remaining=vnfs_remaining,
            action_mask=action_mask,
        )

        return logits, value
