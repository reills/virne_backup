# ==============================================================================
# net.py  (Enhanced Transformer with Deeper GAT and Improved Aggregation)
# ==============================================================================  
from typing import Dict, Optional, Tuple

import torch
import torch.nn as nn
import torch.nn.functional as F
from torch_geometric.nn import GENConv
from torch_geometric.utils import scatter
from torch_geometric.nn import global_mean_pool


class MultiHeadGENLayer(nn.Module):
    def __init__(self, in_dim, out_dim, aggr='softmax', edge_dim=1):
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
        #NEW 
        self.edge_mlp = nn.Sequential(
            nn.Linear(2 * out_dim, out_dim),
            nn.GELU(),
            nn.LayerNorm(out_dim)
        )

    def forward(self, x, edge_index, edge_attr):
        # Update node features
        out_x = self.conv(x, edge_index, edge_attr)
        out_x = self.norm(out_x)
        out_x = F.elu(out_x)
        out_x = self.dropout(out_x)

        # Compute edge features: concat endpoint node features
        row = edge_index[0]
        col = edge_index[1]
        edge_feat = torch.cat([out_x[row], out_x[col]], dim=1)
        out_e = self.edge_mlp(edge_feat)

        return out_x, out_e


# --- ActorCritic Model ---
class ActorCritic(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, v_net_feature_dim,
                 embedding_dim=128, n_heads=8, n_layers=4, dropout=0.1,
                 p_net_edge_dim=1, gnn_layers=3, **kwargs):
        super().__init__()
        
        common_kwargs = dict(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout,
            p_net_edge_dim=p_net_edge_dim,
            gnn_layers=gnn_layers,
            **kwargs  # include allow_rejection, allow_revocable, etc.
        )
        
        max_seq_len = kwargs.get("max_seq_len", 15) 
        self.encoder = Encoder(v_net_feature_dim, embedding_dim, n_heads, n_layers, dropout, max_seq_len=max_seq_len)
        self.actor = Actor(**common_kwargs)
        self.critic = Critic(**common_kwargs)

    def encode(self, obs):
        return self.encoder(obs['v_net_x'])

    @torch.jit.ignore
    def act(self, obs, training=False):
        return self.actor(obs, training=training)


    @torch.jit.ignore
    def evaluate(self, obs):
        return self.critic(obs)

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
            activation='gelu'  # Switch to GELU for better gradient flow
        )
        self.transformer_encoder = nn.TransformerEncoder(encoder_layer, num_layers=n_layers)
        self.norm = nn.LayerNorm(embedding_dim)
        # In Encoder
        nn.init.xavier_uniform_(self.token_embed.weight, gain=1.0)  # Linear layers often use gain=1
        for layer in self.transformer_encoder.layers:
            nn.init.xavier_uniform_(layer.linear1.weight, gain=1.43)  # Approximate gain for GELU
            nn.init.zeros_(layer.linear1.bias)
            nn.init.xavier_uniform_(layer.linear2.weight, gain=1.0)
            nn.init.zeros_(layer.linear2.bias)

    def forward(self, x):  # x: [B, T, F]
        B, T, _ = x.size()
        positions = torch.arange(T, device=x.device).unsqueeze(0).expand(B, T)  # [B, T] 
         
        x = self.token_embed(x) + self.position_embed(positions)               # [B, T, E]
        x = self.transformer_encoder(x)
        return self.norm(x)  # Optional final norm for stabilization

# --- Actor Module ---
class Actor(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128,
                 n_heads=8, n_layers=4, dropout=0.1, gnn_layers=3, **kwargs):
        super().__init__()
        # Retrieve special action flags from kwargs
        # Extract p_net_edge_dim from kwargs to avoid duplicate parameter
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

        # Value head input: decoder features + graph summary features
        combined_dim = embedding_dim + embedding_dim

        self.value_head = nn.Sequential(
            nn.Linear(combined_dim, embedding_dim // 2),
            nn.GELU(),
            nn.Linear(embedding_dim // 2, 1)
        )

    @torch.jit.ignore
    def forward(self, obs):
        # Get full decoder sequence and GAT-processed physical node features
        decoder_outputs, graph_embedding = self.decoder(
            obs, return_all_embeds=True, return_gat_embedding=True, training=False
        )  # decoder_outputs: [B, T, D], graph_embedding: [N, D]

        # Mean pool over sequence
        seq_summary = decoder_outputs.mean(dim=1)  # [B, D]

        # Mean pool over graph embedding (physical node embeddings)
        node_batch = obs['p_net'].batch  # [N]
        graph_summary = global_mean_pool(graph_embedding, node_batch)  # [B, D]

        # Combine and estimate value
        combined = torch.cat([seq_summary, graph_summary], dim=-1)  # [B, 2D]
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
    ) -> torch.Tensor:
        """TorchScript-friendly critic forward for single-graph inputs."""
        decoder_outputs, graph_embedding = self.decoder.embeddings_from_tensors(
            p_net_x=p_net_x,
            p_net_edge_index=p_net_edge_index,
            p_net_edge_attr=p_net_edge_attr,
            p_net_batch=p_net_batch,
            history_features=history_features,
            encoder_outputs=encoder_outputs,
            curr_v_node_id=curr_v_node_id,
            vnfs_remaining=vnfs_remaining,
        )
        seq_summary = decoder_outputs.mean(dim=1)
        # Single graph mean pool
        graph_summary = graph_embedding.mean(dim=0, keepdim=True)
        combined = torch.cat([seq_summary, graph_summary], dim=-1)
        return self.value_head(combined)



# --- Autoregressive Decoder ---
class AutoregressiveDecoder(nn.Module):
    """
    Transformer-based decoder for autoregressive action selection in SFC placement.
    Computes per-node placement logits for physical node assignments.
    """
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128,
                 n_heads=8, n_layers=4, dropout=0.1, is_actor=True,
                 allow_revocable=False, allow_rejection=False, use_amp=False, max_seq_len=15,
                 p_net_edge_dim=1, gnn_layers=3):
        super().__init__()
        self.embedding_dim = embedding_dim
        self.use_amp = use_amp
        self.p_net_num_nodes = p_net_num_nodes
        self.allow_rejection = bool(allow_rejection)
        self.temperature = 1.0

        # Action space: physical node placements (+ optional REJECT)
        self.num_actions = p_net_num_nodes + (1 if self.allow_rejection else 0)
        self.start_token = self.num_actions  # Used for history embeddings (start of sequence)
        self.pad_token = self.num_actions + 1  # Used for sequence padding

 
        # Input embeddings  
        self.step_embedding = nn.Embedding(max_seq_len, embedding_dim)
        self.remaining_embedding = nn.Embedding(max_seq_len + 1, embedding_dim)

        # Physical network encoder (GNN layers)
        self.gat_layers = nn.ModuleList([
            MultiHeadGENLayer(
                in_dim=p_net_feature_dim if i == 0 else embedding_dim,
                out_dim=embedding_dim,
                edge_dim=p_net_edge_dim if i == 0 else embedding_dim
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
    
        # Learnable embeddings (only start_embedding, special actions removed)
        self.start_embedding = nn.Parameter(torch.randn(self.history_feature_dim))
        # TODO: Add revoke_embedding and reject_embedding when implementing special actions
        # self.revoke_embedding = nn.Parameter(torch.randn(self.history_feature_dim))
        # self.reject_embedding = nn.Parameter(torch.randn(self.history_feature_dim))
        
        # Actor heads
        self.is_actor = is_actor
        if is_actor:
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

            # Special actions removed for now (no revoke/reject)
            # TODO: Implement special_action_head when adding revoke/reject support
            # self.special_action_head = nn.Sequential(
            #     nn.Linear(embedding_dim, embedding_dim // 2),
            #     nn.GELU(),
            #     nn.Linear(embedding_dim // 2, 2)
            # )
            
            # Initialization
            nn.init.xavier_uniform_(self.history_embed.weight)
            nn.init.zeros_(self.history_embed.bias)
            for layer in self.node_score_head:
                if isinstance(layer, nn.Linear):
                    nn.init.xavier_uniform_(layer.weight)
                    nn.init.zeros_(layer.bias)
            if self.allow_rejection and self.reject_head is not None:
                for layer in self.reject_head:
                    if isinstance(layer, nn.Linear):
                        nn.init.xavier_uniform_(layer.weight)
                        nn.init.zeros_(layer.bias)

        


    @torch.jit.ignore
    def forward(self, obs, return_last_embed=False, return_all_embeds=False, return_gat_embedding=False, training=False):


        batch_p_net = obs['p_net']
        node_features = batch_p_net.x.float()
        edge_index = batch_p_net.edge_index
        edge_attr = batch_p_net.edge_attr
        
        # Handle both single graphs and batches
        if hasattr(batch_p_net, 'batch') and batch_p_net.batch is not None:
            node_batch = batch_p_net.batch
            B = batch_p_net.num_graphs if hasattr(batch_p_net, 'num_graphs') else 1
        else:
            # Single graph case
            node_batch = torch.zeros(batch_p_net.num_nodes, dtype=torch.long, device=batch_p_net.x.device)
            B = 1

        # Apply GAT layers
        for gat_layer in self.gat_layers:
            node_features, edge_attr = gat_layer(node_features, edge_index, edge_attr)
        graph_embedding = self.gat_projection(node_features)

        # Embed history  
        history_features = obs['history_features']
        action_embeddings = self.history_embed(history_features) 
        combined_target = action_embeddings   
        
        # Transformer decoder
        batch_size, seq_len, _ = combined_target.shape
        causal_mask = torch.triu(
            torch.ones(seq_len, seq_len, device=combined_target.device), diagonal=1
        ).to(dtype=torch.bool)
        padding_mask = torch.all(history_features == 0, dim=-1)

        encoder_outputs = obs['encoder_outputs']
        decoder_output = self.transformer_decoder(
            tgt=combined_target,
            memory=encoder_outputs,
            tgt_mask=causal_mask,
            tgt_key_padding_mask=padding_mask
        )
        if return_all_embeds and return_gat_embedding:
            return decoder_output, graph_embedding
        elif return_all_embeds:
            return decoder_output

        
        last_decoder_output = decoder_output[:, -1, :]
        

        # Add step and remaining count context
        step_emb = self.step_embedding(obs['curr_v_node_id'])
        remaining_emb = self.remaining_embedding(obs['vnfs_remaining'])
        final_context_embedding = self.norm(last_decoder_output + step_emb + remaining_emb)

        # Return early if critic
        if return_last_embed or not self.is_actor:
            return final_context_embedding

        # Cross-attend to nodes
        nodes_per_graph = scatter(torch.ones_like(node_batch), node_batch, dim=0, reduce='sum').long()
        max_nodes = nodes_per_graph.max().item()
        padded_nodes = torch.zeros(B, max_nodes, self.embedding_dim, device=graph_embedding.device)
        node_padding_mask = torch.ones(B, max_nodes, dtype=torch.bool, device=graph_embedding.device)

        for i in range(B):
            idxs = (node_batch == i).nonzero(as_tuple=True)[0]
            padded_nodes[i, :len(idxs)] = graph_embedding[idxs]
            node_padding_mask[i, :len(idxs)] = False

        query = final_context_embedding.unsqueeze(0)
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
            nodes_to_consider = min(num_nodes, self.num_actions)  # Clamp to action space size
            if nodes_to_consider > 0:
                raw_logits_nodes[i, :nodes_to_consider] = node_scores[current_node_idx:current_node_idx + nodes_to_consider]
            current_node_idx += num_nodes

        # Optional REJECT logit
        if self.is_actor and self.allow_rejection and self.reject_head is not None:
            reject_logit = self.reject_head(final_context_embedding)  # [B, 1]
            raw_logits = torch.cat([raw_logits_nodes, reject_logit], dim=-1)  # [B, p_nodes + 1]
        else:
            raw_logits = raw_logits_nodes

        # Apply action mask and clamp 
        safe_logits = torch.clamp(raw_logits, min=-15.0, max=15.0)
        mask      = obs['action_mask'].bool()
        # Use a dtype-safe large finite negative to avoid overflow under autocast
        neg_large = torch.full_like(safe_logits, -1e9)
        final_logits = torch.where(mask, safe_logits, neg_large)

        T = getattr(self, "temperature", 1.0)
        if T != 1.0:
            final_logits = final_logits.clone()
            final_logits[mask] = final_logits[mask] / T
        
        return final_logits  

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
    ) -> Tuple[torch.Tensor, torch.Tensor]:
        """Return decoder and graph embeddings from raw tensors."""
        node_features = p_net_x.float()
        edge_index = p_net_edge_index
        edge_attr = p_net_edge_attr

        for gat_layer in self.gat_layers:
            node_features, edge_attr = gat_layer(node_features, edge_index, edge_attr)
        graph_embedding = self.gat_projection(node_features)

        action_embeddings = self.history_embed(history_features)
        combined_target = action_embeddings

        _, seq_len, _ = combined_target.shape
        causal_mask = torch.triu(
            torch.ones(seq_len, seq_len, device=combined_target.device), diagonal=1
        ).to(dtype=torch.bool)
        padding_mask = torch.all(history_features == 0, dim=-1)

        decoder_output = self.transformer_decoder(
            tgt=combined_target,
            memory=encoder_outputs,
            tgt_mask=causal_mask,
            tgt_key_padding_mask=padding_mask,
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
        return_last_embed: bool = False,
    ) -> torch.Tensor:
        """TorchScript-friendly forward that accepts raw tensors instead of PyG Data.

        This path is used for C++ inference. It assumes a single-graph batch
        (node batch values are all zero) and avoids Python-side objects.
        """
        decoder_output, graph_embedding = self.embeddings_from_tensors(
            p_net_x=p_net_x,
            p_net_edge_index=p_net_edge_index,
            p_net_edge_attr=p_net_edge_attr,
            p_net_batch=p_net_batch,
            history_features=history_features,
            encoder_outputs=encoder_outputs,
            curr_v_node_id=curr_v_node_id,
            vnfs_remaining=vnfs_remaining,
        )

        last_decoder_output = decoder_output[:, -1, :]

        # Add step and remaining count context
        step_emb = self.step_embedding(curr_v_node_id)
        remaining_emb = self.remaining_embedding(vnfs_remaining)
        final_context_embedding = self.norm(last_decoder_output + step_emb + remaining_emb)

        if return_last_embed or not self.is_actor:
            return final_context_embedding

        # Cross-attend to nodes (single graph batch)
        node_batch = p_net_batch
        padded_nodes = graph_embedding.unsqueeze(0)
        node_padding_mask = torch.zeros((1, graph_embedding.size(0)), dtype=torch.bool, device=graph_embedding.device)

        query = final_context_embedding.unsqueeze(0)
        key = value = padded_nodes.transpose(0, 1)
        attn_output, _ = self.node_cross_attention(query=query, key=key, value=value, key_padding_mask=node_padding_mask)
        attn_context = attn_output.squeeze(0)
        attn_context_per_node = attn_context.index_select(0, node_batch)

        # Compute node scores
        combined = torch.cat([
            F.normalize(graph_embedding, dim=-1, eps=1e-6),
            F.normalize(attn_context_per_node, dim=-1, eps=1e-6),
        ], dim=-1)
        node_scores = self.node_score_head(combined).squeeze(-1)

        # Assemble final logits for physical nodes
        raw_logits_nodes = torch.full(
            (1, self.p_net_num_nodes), -20.0, device=node_scores.device, dtype=node_scores.dtype
        )
        nodes_to_consider = node_scores.size(0)
        if nodes_to_consider > self.num_actions:
            nodes_to_consider = self.num_actions
        if nodes_to_consider > 0:
            raw_logits_nodes[0, :nodes_to_consider] = node_scores[:nodes_to_consider]

        if self.is_actor and self.allow_rejection and self.reject_head is not None:
            reject_logit = self.reject_head(final_context_embedding)
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


class ActorCriticScriptWrapper(nn.Module):
    """TorchScript-friendly wrapper around ActorCritic for C++ inference."""

    def __init__(self, model: ActorCritic):
        super().__init__()
        self.model = model

    @torch.jit.export
    def encode(self, v_net_x: torch.Tensor) -> torch.Tensor:
        """Encode virtual network features."""
        return self.model.encoder(v_net_x)

    def forward(self, inputs: Dict[str, torch.Tensor]) -> Tuple[torch.Tensor, torch.Tensor]:
        """Compute policy logits and value from tensor inputs.

        Expected keys:
            p_net_x, p_net_edge_index, p_net_edge_attr, p_net_batch,
            selected_p_nodes, encoder_outputs, curr_v_node_id,
            vnfs_remaining, action_mask
        """
        p_net_x = inputs["p_net_x"]
        p_net_edge_index = inputs["p_net_edge_index"]
        p_net_edge_attr = inputs["p_net_edge_attr"]
        p_net_batch = inputs["p_net_batch"]
        selected_p_nodes = inputs["selected_p_nodes"]
        encoder_outputs = inputs["encoder_outputs"]
        curr_v_node_id = inputs["curr_v_node_id"]
        vnfs_remaining = inputs["vnfs_remaining"]
        action_mask = inputs["action_mask"]

        history_len = selected_p_nodes.size(0) + 1
        history_features = torch.zeros(
            (1, history_len, p_net_x.size(1)),
            device=p_net_x.device,
            dtype=p_net_x.dtype,
        )
        history_features[0, 0, :] = self.model.actor.decoder.start_embedding.to(p_net_x.dtype)
        gathered = torch.index_select(p_net_x, 0, selected_p_nodes)
        history_features[0, 1:history_len, :] = gathered

        logits = self.model.actor.decoder.forward_from_tensors(
            p_net_x=p_net_x,
            p_net_edge_index=p_net_edge_index,
            p_net_edge_attr=p_net_edge_attr,
            p_net_batch=p_net_batch,
            history_features=history_features,
            encoder_outputs=encoder_outputs,
            curr_v_node_id=curr_v_node_id,
            vnfs_remaining=vnfs_remaining,
            action_mask=action_mask,
        )
        value = self.model.critic.forward_from_tensors(
            p_net_x=p_net_x,
            p_net_edge_index=p_net_edge_index,
            p_net_edge_attr=p_net_edge_attr,
            p_net_batch=p_net_batch,
            history_features=history_features,
            encoder_outputs=encoder_outputs,
            curr_v_node_id=curr_v_node_id,
            vnfs_remaining=vnfs_remaining,
        )
        return logits, value
