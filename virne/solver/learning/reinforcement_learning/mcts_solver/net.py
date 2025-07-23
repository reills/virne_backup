# ==============================================================================
# net.py  (Enhanced Transformer with Deeper GAT and Improved Aggregation)
# ==============================================================================  
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
        row, col = edge_index
        edge_feat = torch.cat([out_x[row], out_x[col]], dim=1)
        out_e = self.edge_mlp(edge_feat)

        return out_x, out_e


# --- ActorCritic Model ---
class ActorCritic(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, v_net_feature_dim,
                 embedding_dim=128, n_heads=8, n_layers=4, dropout=0.1,
                 p_net_edge_dim=1, **kwargs):
        super().__init__()
        
        common_kwargs = dict(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout,
            p_net_edge_dim=p_net_edge_dim,
            **kwargs  # include allow_rejection, allow_revocable, etc.
        )
        
        max_seq_len = kwargs.get("max_seq_len", 15) 
        self.encoder = Encoder(v_net_feature_dim, embedding_dim, n_heads, n_layers, dropout, max_seq_len=max_seq_len)
        self.actor = Actor(**common_kwargs)
        self.critic = Critic(**common_kwargs)

    def encode(self, obs):
        return self.encoder(obs['v_net_x'])

    def act(self, obs, training=False):
        return self.actor(obs, training=training)


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
                 n_heads=8, n_layers=4, dropout=0.1, **kwargs):
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
            **kwargs
        )

    def forward(self, obs, training=False):
        return self.decoder(obs, training=training)


class Critic(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128,
                 n_heads=8, n_layers=4, dropout=0.1, **kwargs):
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
            **kwargs
        )

        # Value head input: decoder features + graph summary features
        combined_dim = embedding_dim + embedding_dim

        self.value_head = nn.Sequential(
            nn.Linear(combined_dim, embedding_dim // 2),
            nn.GELU(),
            nn.Linear(embedding_dim // 2, 1)
        )

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



# --- Autoregressive Decoder ---
class AutoregressiveDecoder(nn.Module):
    """
    Transformer-based decoder for autoregressive action selection in SFC placement.
    Computes per-node placement logits and context-based special action logits (revoke/reject).
    """
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=128,
                 n_heads=8, n_layers=4, dropout=0.1, is_actor=True,
                 allow_revocable=False, allow_rejection=False, use_amp=False, max_seq_len=15,
                 p_net_edge_dim=1):
        super().__init__()
        self.embedding_dim = embedding_dim
        self.use_amp = use_amp
        self.p_net_num_nodes = p_net_num_nodes

        # Action indices
        self.revoke_action_idx = p_net_num_nodes
        self.reject_action_idx = p_net_num_nodes + 1
        self.num_actions = p_net_num_nodes + 2
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
                edge_dim=p_net_edge_dim
            )
            for i in range(3)
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
    
        # Learnable embeddings
        self.revoke_embedding = nn.Parameter(torch.randn(self.history_feature_dim))
        self.reject_embedding = nn.Parameter(torch.randn(self.history_feature_dim))
        self.start_embedding = nn.Parameter(torch.randn(self.history_feature_dim))
        
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

            # Predict 2 scores from decoder context (revoke, reject)
            self.special_action_head = nn.Sequential(
                nn.Linear(embedding_dim, embedding_dim // 2),
                nn.GELU(),
                nn.Linear(embedding_dim // 2, 2)
            )
            
            # Initialization
            nn.init.xavier_uniform_(self.history_embed.weight)
            nn.init.zeros_(self.history_embed.bias)
            for layer in self.node_score_head:
                if isinstance(layer, nn.Linear):
                    nn.init.xavier_uniform_(layer.weight)
                    nn.init.zeros_(layer.bias)
            for layer in self.special_action_head:
                if isinstance(layer, nn.Linear):
                    nn.init.xavier_uniform_(layer.weight)
                    nn.init.zeros_(layer.bias)

        


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
            node_features, _ = gat_layer(node_features, edge_index, edge_attr)
        graph_embedding = self.gat_projection(node_features)

        # Embed history  
        history_features = obs['history_features']
        action_embeddings = self.history_embed(history_features) 
        combined_target = action_embeddings   
        
        # Transformer decoder
        batch_size, seq_len, _ = combined_target.shape
        causal_mask = torch.triu(torch.ones(seq_len, seq_len, device=combined_target.device), diagonal=1).bool()
        padding_mask = torch.all(history_features == 0, dim=-1)

        encoder_outputs = obs['encoder_outputs']
        if not isinstance(encoder_outputs, torch.Tensor):
            encoder_outputs = torch.as_tensor(encoder_outputs, dtype=torch.float32, device=combined_target.device)

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
            F.normalize(graph_embedding, dim=-1),
            F.normalize(attn_context_per_node, dim=-1),
        ], dim=-1)
        node_scores = self.node_score_head(combined).squeeze(-1)

        # Compute special action scores
        special_action_scores = self.special_action_head(final_context_embedding)  # (B, 2)

        # Assemble final logits
        raw_logits = torch.full((B, self.num_actions), -20.0, device=node_scores.device, dtype=node_scores.dtype)
        padded_node_scores = torch.full((B, self.p_net_num_nodes), -20.0, device=node_scores.device)

        current_node_idx = 0
        for i in range(B):
            num_nodes = nodes_per_graph[i].item()
            nodes_to_consider = min(num_nodes, self.p_net_num_nodes)
            if nodes_to_consider > 0:
                padded_node_scores[i, :nodes_to_consider] = node_scores[current_node_idx:current_node_idx + nodes_to_consider]
            current_node_idx += num_nodes

        raw_logits[:, :self.p_net_num_nodes] = padded_node_scores
        raw_logits[:, self.revoke_action_idx:self.reject_action_idx + 1] = special_action_scores

        # Apply action mask and clamp 
        safe_logits = torch.clamp(raw_logits, min=-15.0, max=15.0)
        mask      = obs['action_mask'].bool()
        minus_inf = -torch.finfo(raw_logits.dtype).max
        final_logits = torch.where(mask, safe_logits, minus_inf)

        T = getattr(self, "temperature", 1.0)
        if T != 1.0:
            valid = final_logits > minus_inf / 2
            final_logits = final_logits.clone()
            final_logits[valid] = final_logits[valid] / T
        
        return final_logits  
