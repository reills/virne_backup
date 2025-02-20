# ==============================================================================
# net.py (Refactored Transformer for Autoregressive Decoding + Separate Critic Head)
# ==============================================================================
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch_geometric.nn import GCNConv, GATConv
from ..neural_network import GATConvNet, GCNConvNet, ResNetBlock, MLPNet


class ActorCritic(nn.Module):
    """
    High-level actor-critic model that holds:
      - Transformer-based Encoder (for v_net).
      - Actor (autoregressive Transformer Decoder + GCN).
      - Critic (same embedding inputs + separate value head).
    """
    def __init__(self, p_net_num_nodes, p_net_feature_dim, v_net_feature_dim,
                 embedding_dim=64, n_heads=8, n_layers=3, dropout=0.1):
        super().__init__()
        self.encoder = Encoder(
            v_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout
        )
        self.actor = Actor(
            p_net_num_nodes,
            p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout
        )
        self.critic = Critic(
            p_net_num_nodes,
            p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout
        )

    def encode(self, obs):
        """Run the Transformer encoder on the VNF feature sequence."""
        x = obs['v_net_x']  # shape: (batch_size, seq_len, v_net_feature_dim)
        # => returns (batch_size, seq_len, emb)
        encoder_outputs = self.encoder(x)
        return encoder_outputs

    def act(self, obs):
        """Get the action logits from the actor decoder."""
        logits = self.actor(obs)
        return logits

    def evaluate(self, obs):
        """Get the scalar value from the critic decoder."""
        value = self.critic(obs)
        return value


# --- CHANGE 1: We do not do single-step decoding anymore in the Actor;
#               we feed the entire partial sequence "history_actions" to the decoder.
class Actor(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=64,
                 n_heads=8, n_layers=3, dropout=0.1):
        super().__init__()
        self.decoder = AutoregressiveDecoder(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout
        )

    def forward(self, obs):
        """
        Returns action logits of shape (batch_size, p_net_num_nodes),
        derived from the last token's decoder output.
        """
        return self.decoder(obs)


# --- CHANGE 2: Critic now has its own linear "value_head" that produces a single scalar
#               from the final decoder embedding.
class Critic(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim, embedding_dim=64,
                 n_heads=8, n_layers=3, dropout=0.1):
        super().__init__()
        self.decoder = AutoregressiveDecoder(
            p_net_num_nodes=p_net_num_nodes,
            p_net_feature_dim=p_net_feature_dim,
            embedding_dim=embedding_dim,
            n_heads=n_heads,
            n_layers=n_layers,
            dropout=dropout
        )

        self.value_head = nn.Linear(embedding_dim, 1)  # produce single scalar

    def forward(self, obs):
        # The decoder returns the final embedding for the *last* token
        # which we then pass to value_head.
        last_emb = self.decoder(obs, return_last_embed=True)  # shape (batch_size, embedding_dim)
        value = self.value_head(last_emb)  # => (batch_size, 1)
        return value


class Encoder(nn.Module):
    def __init__(self, v_net_feature_dim, embedding_dim=64,
                 n_heads=8, n_layers=3, dropout=0.1):
        super().__init__()
        self.emb = nn.Linear(v_net_feature_dim, embedding_dim)
        encoder_layer = nn.TransformerEncoderLayer(
            d_model=embedding_dim,
            nhead=n_heads,
            dim_feedforward=4 * embedding_dim,
            dropout=dropout,
            batch_first=True
        )
        self.transformer_encoder = nn.TransformerEncoder(
            encoder_layer, num_layers=n_layers
        )

    def forward(self, x):
        """
        x: (batch_size, seq_len, v_net_feature_dim)
        Returns:
          encoder_outputs: (batch_size, seq_len, embedding_dim)
        """
        x = self.emb(x)
        encoder_outputs = self.transformer_encoder(x)  # (batch_size, seq_len, emb)
        return encoder_outputs


# --- CHANGE 3: A new "AutoregressiveDecoder" that:
#               1) Takes the entire sequence of actions: shape (batch_size, t).
#               2) Embeds them -> shape (batch_size, t, emb).
#               3) Applies a causal mask so each token sees only [0..i-1].
#               4) The final token embedding is used to produce the action logits or value.
class AutoregressiveDecoder(nn.Module):
    def __init__(self, p_net_num_nodes, p_net_feature_dim,
                 embedding_dim=64, n_heads=8, n_layers=3, dropout=0.1):
        super().__init__()
        self.vocab_size = p_net_num_nodes + 1  # +1 if we used <start_token> or <pad_token>
        self.emb = nn.Embedding(self.vocab_size, embedding_dim)

        # GCN to embed the physical nodes
        self.gcn = GCNConvNet(
            input_dim=p_net_feature_dim,
            hidden_dim=embedding_dim,
            embedding_dim=embedding_dim,
            dropout_prob=0.,
            return_batch=True
        )

        decoder_layer = nn.TransformerDecoderLayer(
            d_model=embedding_dim,
            nhead=n_heads,
            dim_feedforward=4 * embedding_dim,
            dropout=dropout,
            batch_first=True
        )
        self.transformer_decoder = nn.TransformerDecoder(decoder_layer, num_layers=n_layers)

        # For the Actor: MLP that merges [node_emb, dec_out] => logit
        # We'll do a simple 2*emb => 1. Then flatten.
        self.mlp = nn.Sequential(
            nn.Linear(2 * embedding_dim, 1),
            nn.Flatten()  # => shape (batch_size, num_nodes)
        )

    def forward(self, obs, return_last_embed=False):
        """
        obs must have:
          - 'p_net'           : PyG Batch
          - 'history_actions' : (batch_size, t) partial action sequence
          - 'encoder_outputs' : (batch_size, seq_len, emb) from the Transformer encoder
          - 'action_mask'     : optional
        If return_last_embed=True, we skip producing logits for the actor
        and return just the final decoder embedding for the last token
        (used by Critic).
        """
        # 1) Get the physical node embeddings from GCN
        batch_p_net = obs['p_net']
        p_node_embeddings = self.gcn(batch_p_net) 
        # reshape => (batch_size, num_p_nodes, emb)
        p_node_embeddings = p_node_embeddings.reshape(
            batch_p_net.num_graphs, -1, p_node_embeddings.shape[-1]
        )  # (B, N, emb)

        # 2) Prepare the entire target sequence for the Transformer decoder
        #    shape => (batch_size, t)
        tgt_seq = obs['history_actions']  # (B, t)

        # 3) Embed the target sequence => (B, t, emb)
        tgt_emb = self.emb(tgt_seq)

        # 4) Build a causal mask so token i sees only [0..i-1]
        B, T, E = tgt_emb.shape
        causal_mask = torch.triu(
            torch.ones(T, T, device=tgt_emb.device, dtype=torch.bool),
            diagonal=1
        )
        # True means "BLOCK" in PyTorch's attn mask. So this ensures no future info.

        # 5) (Optional) memory_key_padding_mask for padded encoder tokens
        memory = obs['encoder_outputs']  # (B, seq_len, emb)
        # We might need obs['mask'] to identify valid tokens in memory. 
        # For illustration, we skip that or assume everything is valid:
        memory_key_padding_mask = None

        # 6) Pass through the Transformer Decoder => (B, T, emb)
        dec_out_seq = self.transformer_decoder(
            tgt=tgt_emb,
            memory=memory,
            tgt_mask=causal_mask,
            memory_key_padding_mask=memory_key_padding_mask
        )

        # The last token's embedding => shape (B, 1, emb)
        last_dec_out = dec_out_seq[:, -1:, :]  # (B, 1, E)

        if return_last_embed:
            # This is used by the Critic to produce a single scalar.
            return last_dec_out.squeeze(1)  # => (B, E)

        # 7) For the Actor: We combine the last decoder output with each node embedding
        #    so we get a distribution over nodes.
        #    shape => (B, N, 2*E)
        expanded_dec_out = last_dec_out.expand(-1, p_node_embeddings.size(1), -1)
        combined = torch.cat([p_node_embeddings, expanded_dec_out], dim=-1)

        # 8) Project to (B, N) => the unnormalized logits for each node
        logits = self.mlp(combined)
        return logits
