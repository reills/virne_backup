from __future__ import annotations

import torch

from virne.solver.learning.reinforcement_learning.alpha_vne.net import SharedBackbone


def _make_backbone() -> SharedBackbone:
    return SharedBackbone(
        p_net_num_nodes=4,
        p_net_feature_dim=3,
        embedding_dim=8,
        n_heads=2,
        n_layers=1,
        dropout=0.0,
        max_seq_len=6,
        p_net_edge_dim=1,
        gnn_layers=1,
    )


def test_history_padding_uses_explicit_lengths_not_zero_features():
    backbone = _make_backbone()

    history_features = torch.zeros((2, 4, 3), dtype=torch.float32)
    history_lengths = torch.tensor([4, 2], dtype=torch.long)

    padding_mask = backbone._build_history_padding_mask(history_features, history_lengths)

    expected = torch.tensor(
        [
            [False, False, False, False],
            [False, False, True, True],
        ],
        dtype=torch.bool,
    )
    assert torch.equal(padding_mask, expected)


def test_history_padding_falls_back_when_lengths_missing():
    backbone = _make_backbone()

    history_features = torch.tensor(
        [[[1.0, 0.0, 0.0], [0.0, 0.0, 0.0], [2.0, 0.0, 0.0]]],
        dtype=torch.float32,
    )

    padding_mask = backbone._build_history_padding_mask(history_features, None)
    expected = torch.tensor([[False, True, False]], dtype=torch.bool)

    assert torch.equal(padding_mask, expected)
