import torch
from torch_geometric.data import Data

from virne.solver.learning.reinforcement_learning.alpha_vne.observation_builder import ObservationBuilder


class DummyDecoder:
    def __init__(self):
        self.start_embedding = torch.tensor([0.5, 1.5], dtype=torch.float32)
        self.num_actions = 4


class DummyActor:
    def __init__(self):
        self.decoder = DummyDecoder()


class DummyPolicy:
    def __init__(self):
        self.actor = DummyActor()


class SparseCppState:
    def __init__(self, selected, virtual_order, candidates, node_alloc, link_alloc):
        self.selected_physical_nodes = list(selected)
        self.virtual_order = list(virtual_order)
        self._candidates = list(candidates)
        self._node_alloc = node_alloc
        self._link_alloc = link_alloc

    def get_candidate_nodes(self):
        return list(self._candidates)

    def get_allocated_node_resources(self):
        return self._node_alloc

    def get_allocated_link_resources(self):
        return self._link_alloc

    def get_available_node_resource(self, *_args, **_kwargs):
        raise AssertionError("Sparse path should not call get_available_node_resource.")

    def get_available_link_resource(self, *_args, **_kwargs):
        raise AssertionError("Sparse path should not call get_available_link_resource.")


class FallbackCppState:
    def __init__(self, selected, virtual_order, candidates, node_available, link_available):
        self.selected_physical_nodes = list(selected)
        self.virtual_order = list(virtual_order)
        self._candidates = list(candidates)
        self._node_available = node_available
        self._link_available = link_available
        self.node_queries = 0
        self.link_queries = 0

    def get_candidate_nodes(self):
        return list(self._candidates)

    def get_available_node_resource(self, node_id, attr_name):
        self.node_queries += 1
        return float(self._node_available[(int(node_id), str(attr_name))])

    def get_available_link_resource(self, edge_id, attr_name):
        self.link_queries += 1
        return float(self._link_available[(int(edge_id), str(attr_name))])


def _make_builder():
    p_data = Data(
        x=torch.tensor(
            [
                [10.0, 20.0],
                [30.0, 40.0],
                [50.0, 60.0],
            ],
            dtype=torch.float32,
        ),
        edge_index=torch.tensor([[0, 1], [1, 2]], dtype=torch.long),
        edge_attr=torch.tensor([[100.0], [200.0]], dtype=torch.float32),
        num_nodes=3,
    )
    v_data = Data(
        x=torch.tensor([[1.0], [2.0]], dtype=torch.float32),
        edge_index=torch.tensor([[0], [1]], dtype=torch.long),
    )
    encoder_outputs = torch.zeros((1, 2, 2), dtype=torch.float32)
    builder = ObservationBuilder(controller=None, device=torch.device("cpu"))
    builder.set_episode_data(p_data, v_data, encoder_outputs)
    return builder


def test_build_from_cpp_state_uses_sparse_incremental_updates():
    builder = _make_builder()
    policy = DummyPolicy()
    node_resource_names = ["cpu", "mem"]
    link_resource_names = ["bw"]
    edge_lookup = {
        (0, 1): 0,
        (1, 0): 0,
        (1, 2): 1,
        (2, 1): 1,
    }

    state_1 = SparseCppState(
        selected=[0],
        virtual_order=[0, 1, 2],
        candidates=[0, 2],
        node_alloc={0: {"cpu": 3.0, "mem": 4.0}},
        link_alloc={0: {"bw": 5.0}},
    )
    obs_1 = builder.build_from_cpp_state(
        cpp_state=state_1,
        policy=policy,
        node_resource_names=node_resource_names,
        link_resource_names=link_resource_names,
        edge_lookup=edge_lookup,
    )
    x_1 = obs_1["p_net"].x.clone()
    edge_attr_1 = obs_1["p_net"].edge_attr.clone()
    assert x_1[0].tolist() == [7.0, 16.0]
    assert x_1[1].tolist() == [30.0, 40.0]
    assert edge_attr_1[0].tolist() == [95.0]
    assert edge_attr_1[1].tolist() == [200.0]

    state_2 = SparseCppState(
        selected=[0, 2],
        virtual_order=[0, 1, 2],
        candidates=[1, 2],
        node_alloc={
            0: {"cpu": 3.0, "mem": 4.0},
            2: {"cpu": 11.0, "mem": 13.0},
        },
        link_alloc={
            0: {"bw": 8.0},
            1: {"bw": 2.0},
        },
    )
    obs_2 = builder.build_from_cpp_state(
        cpp_state=state_2,
        policy=policy,
        node_resource_names=node_resource_names,
        link_resource_names=link_resource_names,
        edge_lookup=edge_lookup,
    )
    x_2 = obs_2["p_net"].x.clone()
    edge_attr_2 = obs_2["p_net"].edge_attr.clone()
    assert x_2[2].tolist() == [39.0, 47.0]
    assert edge_attr_2[0].tolist() == [92.0]
    assert edge_attr_2[1].tolist() == [198.0]

    state_3 = SparseCppState(
        selected=[0],
        virtual_order=[0, 1, 2],
        candidates=[0, 2],
        node_alloc={0: {"cpu": 3.0, "mem": 4.0}},
        link_alloc={0: {"bw": 5.0}},
    )
    obs_3 = builder.build_from_cpp_state(
        cpp_state=state_3,
        policy=policy,
        node_resource_names=node_resource_names,
        link_resource_names=link_resource_names,
        edge_lookup=edge_lookup,
    )
    x_3 = obs_3["p_net"].x.clone()
    edge_attr_3 = obs_3["p_net"].edge_attr.clone()
    assert x_3[2].tolist() == [50.0, 60.0]
    assert edge_attr_3[1].tolist() == [200.0]
    assert obs_3["action_mask"].shape == (1, 4)
    assert obs_3["action_mask"][0, 0]
    assert obs_3["action_mask"][0, 2]


def test_build_from_cpp_state_falls_back_to_full_refresh_without_sparse_api():
    builder = _make_builder()
    policy = DummyPolicy()
    node_resource_names = ["cpu", "mem"]
    link_resource_names = ["bw"]
    edge_lookup = {
        (0, 1): 0,
        (1, 0): 0,
        (1, 2): 1,
        (2, 1): 1,
    }
    state = FallbackCppState(
        selected=[1],
        virtual_order=[0, 1, 2],
        candidates=[1],
        node_available={
            (0, "cpu"): 9.0,
            (0, "mem"): 18.0,
            (1, "cpu"): 28.0,
            (1, "mem"): 35.0,
            (2, "cpu"): 50.0,
            (2, "mem"): 60.0,
        },
        link_available={
            (0, "bw"): 97.0,
            (1, "bw"): 188.0,
        },
    )

    obs = builder.build_from_cpp_state(
        cpp_state=state,
        policy=policy,
        node_resource_names=node_resource_names,
        link_resource_names=link_resource_names,
        edge_lookup=edge_lookup,
    )
    assert state.node_queries == 6
    assert state.link_queries == 2
    assert obs["p_net"].x[1].tolist() == [28.0, 35.0]
    assert obs["p_net"].edge_attr[1].tolist() == [188.0]
