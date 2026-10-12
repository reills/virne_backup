#!/usr/bin/env python3
"""Run the official FlagVNE implementation on fixed Virne datasets.

This adapter deliberately imports FlagVNE from a separately checked out, pinned
author repository.  It does not vendor or alter the author code.  It creates a
legacy metadata view for the newer nested ``output`` mapping and normalizes one
GML metadata type in memory (``"True"``/``"False"`` to Boolean) for the older
author classes.  Source payload files are never modified.

One invocation trains and evaluates one cell in one Python process.  The same
trained solver object is used for evaluation, and an explicit checkpoint is
also saved for provenance.
"""

from __future__ import annotations

import argparse
import contextlib
import csv
import datetime as dt
import hashlib
import importlib
import json
import math
import os
import re
import shutil
import subprocess
import sys
import traceback
from pathlib import Path
from typing import Any, Iterator, Mapping, Sequence

import networkx as nx
import yaml


REPO_ROOT = Path(__file__).resolve().parents[1]
FLAGVNE_REPOSITORY = "https://github.com/GeminiLight/flag-vne"
FLAGVNE_COMMIT = "06c65225a6bd42ffaa85c1046196b90b096b6ac1"
REQUIRED_UPSTREAM_FILES = (
    "main.py",
    "vne_simulator/config.py",
    "vne_simulator/base/scenario.py",
    "vne_simulator/base/environment.py",
    "vne_simulator/base/recorder.py",
    "vne_simulator/data/physical_network.py",
    "vne_simulator/data/virtual_network_request_simulator.py",
    "vne_simulator/solver/learning/flag_vne/solver.py",
    "vne_simulator/solver/learning/flag_vne/net.py",
    "vne_simulator/solver/learning/flag_vne/instance_env.py",
)
PAYLOAD_NAMES = (
    "p_net.gml",
    "events.yaml",
    "v_sim_setting.yaml",
    "generation_metadata.json",
)
OUTPUT_KEYS = {
    "events_file_name",
    "setting_file_name",
    "save_dir",
    "v_nets_file_name",
    "v_nets_save_dir",
}
NORMALIZED_FIELDS = (
    "solver_name",
    "topology",
    "scenario",
    "seed",
    "k_shortest",
    "num_arrival_requests",
    "num_train_epochs",
    "num_meta_learning_epochs",
    "acceptance_rate",
    "long_term_r2c_ratio",
    "clock_running_time",
    "success_count",
    "run_id",
    "source_train_dataset_dir",
    "source_dataset_dir",
    "dataset_tree_sha256",
    "official_summary_path",
    "official_records_paths",
    "checkpoint_path",
    "upstream_commit",
    "status",
)


class AdapterError(RuntimeError):
    """Raised when an input or author output fails a strict adapter check."""


def utc_now() -> str:
    return dt.datetime.now(dt.timezone.utc).replace(microsecond=0).isoformat()


def resolved(path: Path) -> Path:
    return path.expanduser().resolve()


def relative_or_absolute(path: Path) -> str:
    path = resolved(path)
    try:
        return str(path.relative_to(REPO_ROOT))
    except ValueError:
        return str(path)


def is_within(path: Path, parent: Path) -> bool:
    try:
        resolved(path).relative_to(resolved(parent))
        return True
    except ValueError:
        return False


def run_checked(command: Sequence[str], *, cwd: Path | None = None) -> str:
    proc = subprocess.run(
        list(command),
        cwd=None if cwd is None else str(cwd),
        check=False,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    if proc.returncode:
        detail = proc.stderr.strip() or proc.stdout.strip()
        raise AdapterError(f"command failed ({proc.returncode}): {' '.join(command)}\n{detail}")
    return proc.stdout.strip()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def file_entry(path: Path, *, base: Path | None = None) -> dict[str, Any]:
    actual = path.resolve(strict=True)
    label = str(path.relative_to(base)) if base is not None else str(path)
    return {
        "path": label,
        "resolved_path": str(actual),
        "size_bytes": actual.stat().st_size,
        "sha256": sha256_file(actual),
        "is_symlink": path.is_symlink(),
    }


def tree_digest(file_entries: Sequence[Mapping[str, Any]]) -> str:
    """Hash an ordered path/digest inventory without depending on mtimes."""
    digest = hashlib.sha256()
    for entry in sorted(file_entries, key=lambda item: str(item["path"])):
        digest.update(str(entry["path"]).encode("utf-8"))
        digest.update(b"\0")
        digest.update(str(entry["sha256"]).encode("ascii"))
        digest.update(b"\n")
    return digest.hexdigest()


def write_json(path: Path, value: Mapping[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(path.name + ".tmp")
    temporary.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    temporary.replace(path)


def load_yaml(path: Path) -> Any:
    try:
        with path.open(encoding="utf-8") as handle:
            return yaml.safe_load(handle)
    except Exception as exc:
        raise AdapterError(f"cannot read YAML {path}: {exc}") from exc


def write_yaml(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as handle:
        yaml.safe_dump(value, handle, sort_keys=False)


def graph_node_count(path: Path) -> int:
    # NetworkX GML writes graph nodes at exactly one indentation level.  This
    # avoids importing the author stack during preflight.
    with path.open(encoding="utf-8") as handle:
        count = sum(1 for line in handle if line.rstrip("\n\r") == "  node [")
    if count <= 0:
        raise AdapterError(f"no graph nodes found in {path}")
    return count


def normalize_gml_attribute_settings(graph: nx.Graph, path: Path) -> None:
    """Normalize Boolean metadata emitted as strings by newer NetworkX."""
    for key in ("node_attrs_setting", "link_attrs_setting"):
        value = graph.graph.get(key)
        if not isinstance(value, list) or not all(isinstance(item, Mapping) for item in value):
            raise AdapterError(f"network {path} has invalid {key!r} metadata")
        normalized = []
        for source_item in value:
            item = dict(source_item)
            generative = item.get("generative")
            if isinstance(generative, str):
                if generative not in ("True", "False"):
                    raise AdapterError(
                        f"network {path} has invalid generative metadata {generative!r}"
                    )
                item["generative"] = generative == "True"
            normalized.append(item)
        graph.graph[key] = normalized


def read_compatible_gml(path: Path) -> nx.Graph:
    """Read fixed GML using the author's integer conversion plus Boolean repair."""
    try:
        graph = nx.read_gml(path, destringizer=int)
    except Exception as exc:
        raise AdapterError(f"cannot read fixed network {path}: {exc}") from exc
    normalize_gml_attribute_settings(graph, path)
    return graph


def graph_payload(graph: nx.Graph) -> dict[str, Any]:
    """Canonical node/edge payload used to verify in-memory author conversion."""
    def attrs(value: Mapping[str, Any]) -> tuple[tuple[str, str], ...]:
        return tuple(sorted((str(key), repr(item)) for key, item in value.items()))

    nodes = sorted((repr(node), attrs(data)) for node, data in graph.nodes(data=True))
    edges = []
    for left, right, data in graph.edges(data=True):
        pair = sorted((repr(left), repr(right))) if not graph.is_directed() else [repr(left), repr(right)]
        edges.append((pair[0], pair[1], attrs(data)))
    return {"nodes": nodes, "edges": sorted(edges)}


def graph_structure_digest(path: Path) -> str:
    """Hash node identities and adjacency while ignoring generated capacities."""
    try:
        graph = nx.read_gml(path, label="id")
    except Exception as exc:
        raise AdapterError(f"cannot read physical-network structure from {path}: {exc}") from exc

    def key(value: Any) -> str:
        return f"{type(value).__name__}:{value}"

    nodes = sorted(key(node) for node in graph.nodes)
    edges: list[tuple[str, str]] = []
    for left, right in graph.edges:
        pair = (key(left), key(right))
        if not graph.is_directed() and pair[1] < pair[0]:
            pair = (pair[1], pair[0])
        edges.append(pair)
    payload = {
        "directed": graph.is_directed(),
        "multigraph": graph.is_multigraph(),
        "nodes": nodes,
        "edges": sorted(edges),
    }
    return hashlib.sha256(
        json.dumps(payload, separators=(",", ":"), sort_keys=True).encode("utf-8")
    ).hexdigest()


def physical_resource_settings(path: Path) -> tuple[list[dict[str, Any]], list[dict[str, Any]]]:
    """Read the physical resource schema embedded in the fixed GML payload."""
    graph = read_compatible_gml(path)
    settings: list[list[dict[str, Any]]] = []
    for key in ("node_attrs_setting", "link_attrs_setting"):
        value = graph.graph.get(key)
        if not isinstance(value, list) or not all(isinstance(item, Mapping) for item in value):
            raise AdapterError(f"physical network {path} has invalid {key!r} metadata")
        settings.append([dict(item) for item in value])
    return settings[0], settings[1]


def normalized_output(setting: Mapping[str, Any]) -> dict[str, Any]:
    output = setting.get("output", {})
    if output is None:
        output = {}
    if not isinstance(output, Mapping):
        raise AdapterError("v_sim_setting.yaml output must be a mapping")
    merged = {key: setting.get(key, output.get(key)) for key in OUTPUT_KEYS}
    merged.setdefault("events_file_name", "events.yaml")
    merged.setdefault("setting_file_name", "v_sim_setting.yaml")
    merged.setdefault("v_nets_file_name", "v_net.gml")
    merged.setdefault("v_nets_save_dir", "v_nets")
    return merged


def experimental_setting(setting: Mapping[str, Any]) -> dict[str, Any]:
    """Return fields that affect requests, excluding storage metadata."""
    return {
        key: value
        for key, value in setting.items()
        if key != "output" and key not in OUTPUT_KEYS
    }


def validate_dataset(dataset_dir: Path) -> dict[str, Any]:
    dataset_dir = resolved(dataset_dir)
    if not dataset_dir.is_dir():
        raise AdapterError(f"dataset directory does not exist: {dataset_dir}")
    required = {name: dataset_dir / name for name in PAYLOAD_NAMES}
    missing = [str(path) for path in required.values() if not path.is_file()]
    v_nets_dir = dataset_dir / "v_nets"
    if not v_nets_dir.is_dir():
        missing.append(str(v_nets_dir))
    if missing:
        raise AdapterError("fixed dataset is incomplete: " + ", ".join(missing))

    setting = load_yaml(required["v_sim_setting.yaml"])
    if not isinstance(setting, Mapping):
        raise AdapterError(f"setting is not a mapping: {required['v_sim_setting.yaml']}")
    for key in (
        "num_v_nets",
        "node_attrs_setting",
        "link_attrs_setting",
        "v_net_size",
        "topology",
        "arrival_rate",
        "lifetime",
    ):
        if key not in setting:
            raise AdapterError(f"missing {key!r} in {required['v_sim_setting.yaml']}")

    node_resource_names = [
        item.get("name")
        for item in setting["node_attrs_setting"]
        if isinstance(item, Mapping) and item.get("type") == "resource"
    ]
    link_resource_names = [
        item.get("name")
        for item in setting["link_attrs_setting"]
        if isinstance(item, Mapping) and item.get("type") == "resource"
    ]
    if node_resource_names != ["cpu"] or link_resource_names != ["bw"]:
        raise AdapterError(
            f"{dataset_dir}: expected the manuscript CPU/bandwidth resource schema, "
            f"found nodes={node_resource_names!r}, links={link_resource_names!r}"
        )

    p_node_settings, p_link_settings = physical_resource_settings(required["p_net.gml"])
    p_node_resource_names = [
        item.get("name") for item in p_node_settings if item.get("type") == "resource"
    ]
    p_link_resource_names = [
        item.get("name") for item in p_link_settings if item.get("type") == "resource"
    ]
    if p_node_resource_names != ["cpu"] or p_link_resource_names != ["bw"]:
        raise AdapterError(
            f"{dataset_dir}: expected physical CPU/bandwidth resources, "
            f"found nodes={p_node_resource_names!r}, links={p_link_resource_names!r}"
        )

    try:
        generation_metadata = json.loads(
            required["generation_metadata.json"].read_text(encoding="utf-8")
        )
    except Exception as exc:
        raise AdapterError(
            f"cannot read generation metadata {required['generation_metadata.json']}: {exc}"
        ) from exc
    if not isinstance(generation_metadata, Mapping):
        raise AdapterError(f"generation metadata is not a mapping: {dataset_dir}")

    vnet_files = sorted(v_nets_dir.glob("*.gml"))
    expected_count = int(setting["num_v_nets"])
    if len(vnet_files) != expected_count:
        raise AdapterError(
            f"{dataset_dir}: num_v_nets={expected_count}, but found {len(vnet_files)} GML files"
        )
    expected_names = [f"v_net-{index:05d}.gml" for index in range(expected_count)]
    actual_names = [path.name for path in vnet_files]
    if actual_names != expected_names:
        raise AdapterError(
            f"{dataset_dir}: virtual-network filenames must be contiguous v_net-00000.gml ..."
        )

    events = load_yaml(required["events.yaml"])
    if not isinstance(events, list) or len(events) != 2 * expected_count:
        raise AdapterError(
            f"{dataset_dir}: expected {2 * expected_count} arrival/departure events"
        )
    event_ids = sorted(int(event.get("id", -1)) for event in events if isinstance(event, Mapping))
    if event_ids != list(range(len(events))):
        raise AdapterError(f"{dataset_dir}: event ids are missing, duplicated, or non-contiguous")
    event_pairs: dict[int, set[int]] = {index: set() for index in range(expected_count)}
    previous_time = -math.inf
    for event in events:
        if not isinstance(event, Mapping):
            raise AdapterError(f"{dataset_dir}: event entry is not a mapping")
        v_net_id = int(event.get("v_net_id", -1))
        event_type = int(event.get("type", -1))
        try:
            event_time = float(event.get("time"))
        except (TypeError, ValueError) as exc:
            raise AdapterError(f"{dataset_dir}: invalid event time in {event}") from exc
        if not math.isfinite(event_time) or event_time < previous_time:
            raise AdapterError(f"{dataset_dir}: event times are not finite and nondecreasing")
        previous_time = event_time
        if v_net_id not in event_pairs or event_type not in (0, 1):
            raise AdapterError(f"{dataset_dir}: invalid event {event}")
        if event_type in event_pairs[v_net_id]:
            raise AdapterError(f"{dataset_dir}: duplicate event type for v_net_id={v_net_id}")
        event_pairs[v_net_id].add(event_type)
    if any(types != {0, 1} for types in event_pairs.values()):
        raise AdapterError(f"{dataset_dir}: each virtual network needs one arrival and one departure")

    payload_files = [required["p_net.gml"], required["events.yaml"], required["v_sim_setting.yaml"]]
    payload_files.extend(vnet_files)
    files = [file_entry(path, base=dataset_dir) for path in payload_files]
    return {
        "path": str(dataset_dir),
        "p_net_node_count": graph_node_count(required["p_net.gml"]),
        "num_v_nets": expected_count,
        "node_attrs_setting": setting["node_attrs_setting"],
        "link_attrs_setting": setting["link_attrs_setting"],
        "p_net_node_attrs_setting": p_node_settings,
        "p_net_link_attrs_setting": p_link_settings,
        "experimental_setting": experimental_setting(setting),
        "output_metadata": normalized_output(setting),
        "generation_metadata": dict(generation_metadata),
        "p_net_sha256": sha256_file(required["p_net.gml"]),
        "p_net_structure_sha256": graph_structure_digest(required["p_net.gml"]),
        "tree_sha256": tree_digest(files),
        "files": files,
    }


def validate_dataset_pair(train_dir: Path, eval_dir: Path) -> dict[str, Any]:
    train = validate_dataset(train_dir)
    evaluation = validate_dataset(eval_dir)
    if train["p_net_node_count"] != evaluation["p_net_node_count"]:
        raise AdapterError(
            "train/eval physical networks have different node counts; the official FlagVNE "
            "policy fixes this dimension at construction time"
        )
    for key in ("node_attrs_setting", "link_attrs_setting"):
        if train[key] != evaluation[key]:
            raise AdapterError(f"train/eval {key} differ; one FlagVNE policy cannot represent both")
    for key in ("p_net_node_attrs_setting", "p_net_link_attrs_setting"):
        if train[key] != evaluation[key]:
            raise AdapterError(f"train/eval physical-network {key} differ")
    if train["p_net_structure_sha256"] != evaluation["p_net_structure_sha256"]:
        raise AdapterError("train/eval physical-network topologies differ")
    if train["experimental_setting"] != evaluation["experimental_setting"]:
        raise AdapterError("train/eval request-generation settings differ")
    return {"train": train, "eval": evaluation}


def checkout_info(flagvne_root: Path) -> dict[str, Any]:
    flagvne_root = resolved(flagvne_root)
    if not flagvne_root.is_dir():
        raise AdapterError(
            f"missing FlagVNE checkout: {flagvne_root}\n"
            f"Clone {FLAGVNE_REPOSITORY} and check out {FLAGVNE_COMMIT}."
        )
    missing = [str(flagvne_root / item) for item in REQUIRED_UPSTREAM_FILES if not (flagvne_root / item).is_file()]
    if missing:
        raise AdapterError("author checkout is incomplete: " + ", ".join(missing))
    head = run_checked(("git", "-C", str(flagvne_root), "rev-parse", "HEAD"))
    if head != FLAGVNE_COMMIT:
        raise AdapterError(
            f"FlagVNE checkout is at {head}; required pinned commit is {FLAGVNE_COMMIT}"
        )
    tracked_changes = run_checked(
        ("git", "-C", str(flagvne_root), "status", "--porcelain", "--untracked-files=no")
    )
    if tracked_changes:
        raise AdapterError("author checkout has tracked modifications; refusing an unpinned implementation")
    license_candidates = sorted(
        path.name
        for path in flagvne_root.iterdir()
        if path.is_file() and path.name.lower().startswith(("license", "copying"))
    )
    return {
        "repository": FLAGVNE_REPOSITORY,
        "path": str(flagvne_root),
        "commit": head,
        "tracked_tree_clean": True,
        "license_files": license_candidates,
        "license_warning": (
            None
            if license_candidates
            else "The pinned upstream tree contains no LICENSE/COPYING file; do not redistribute its source."
        ),
        "required_files": [file_entry(flagvne_root / item, base=flagvne_root) for item in REQUIRED_UPSTREAM_FILES],
    }


def preflight(args: argparse.Namespace) -> dict[str, Any]:
    if args.train_dataset_dir is None or args.eval_dataset_dir is None:
        raise AdapterError("--train-dataset and --test-dataset are required for preflight")
    checkout = checkout_info(args.flagvne_root)
    datasets = validate_dataset_pair(args.train_dataset_dir, args.eval_dataset_dir)
    for split, dataset in (("train", datasets["train"]), ("test", datasets["eval"])):
        metadata = dataset["generation_metadata"]
        expected = {
            "topology": args.topology,
            "scenario": args.scenario,
            "seed": args.seed,
            "split": split,
        }
        for key, value in expected.items():
            if metadata.get(key) != value:
                raise AdapterError(
                    f"{split} generation metadata {key} mismatch: "
                    f"expected {value!r}, found {metadata.get(key)!r}"
                )
    return {
        "schema_version": 1,
        "status": "preflight_ok",
        "checked_at": utc_now(),
        "adapter": relative_or_absolute(Path(__file__)),
        "upstream": checkout,
        "datasets": datasets,
        "constraints": {
            "payload_files_are_never_rewritten": True,
            "legacy_view_changes_storage_metadata_only": True,
            "gml_boolean_metadata_is_normalized_in_memory": True,
            "node_and_edge_payloads_are_verified_after_conversion": True,
            "train_and_eval_share_one_process": True,
            "policy_requires_equal_train_eval_p_net_node_count": True,
            "policy_requires_equal_train_eval_resource_schema": True,
        },
    }


def legacy_vsim_setting(source_setting: Mapping[str, Any], save_dir: Path) -> dict[str, Any]:
    output = normalized_output(source_setting)
    legacy = dict(source_setting)
    legacy.pop("output", None)
    for key in OUTPUT_KEYS:
        legacy.pop(key, None)
    legacy.update(output)
    legacy["save_dir"] = str(resolved(save_dir))
    legacy["events_file_name"] = "events.yaml"
    legacy["setting_file_name"] = "v_sim_setting.yaml"
    legacy["v_nets_save_dir"] = "v_nets"
    if experimental_setting(source_setting) != experimental_setting(legacy):
        raise AdapterError("legacy conversion changed an experimental setting")
    return legacy


def pnet_setting(p_net_path: Path, save_dir: Path) -> dict[str, Any]:
    node_settings, link_settings = physical_resource_settings(p_net_path)
    return {
        "num_nodes": graph_node_count(p_net_path),
        "node_attrs_setting": node_settings,
        "link_attrs_setting": link_settings,
        "topology": {"type": "file", "file_path": str(resolved(p_net_path))},
        "save_dir": str(resolved(save_dir)),
        "file_name": "p_net.gml",
    }


def symlink_exact(source: Path, destination: Path) -> None:
    source = resolved(source)
    if destination.exists() or destination.is_symlink():
        raise AdapterError(f"adapter destination already exists: {destination}")
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.symlink_to(source, target_is_directory=source.is_dir())
    if destination.resolve(strict=True) != source:
        raise AdapterError(f"symlink does not resolve to its source: {destination}")


def prepare_legacy_payload(source_dir: Path, destination_dir: Path, legacy_setting: Mapping[str, Any]) -> None:
    source_dir = resolved(source_dir)
    destination_dir.mkdir(parents=True, exist_ok=False)
    symlink_exact(source_dir / "p_net.gml", destination_dir / "p_net.gml")
    symlink_exact(source_dir / "events.yaml", destination_dir / "events.yaml")
    symlink_exact(source_dir / "v_nets", destination_dir / "v_nets")
    write_yaml(destination_dir / "v_sim_setting.yaml", dict(legacy_setting))
    written = load_yaml(destination_dir / "v_sim_setting.yaml")
    source = load_yaml(source_dir / "v_sim_setting.yaml")
    if experimental_setting(source) != experimental_setting(written):
        raise AdapterError("written legacy setting changed an experimental value")
    for name in ("p_net.gml", "events.yaml"):
        if sha256_file(source_dir / name) != sha256_file(destination_dir / name):
            raise AdapterError(f"adapter changed payload bytes for {name}")


@contextlib.contextmanager
def pushd(path: Path) -> Iterator[None]:
    previous = Path.cwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(previous)


def import_author_api(flagvne_root: Path) -> dict[str, Any]:
    flagvne_root = resolved(flagvne_root)
    sys.path.insert(0, str(flagvne_root))
    try:
        package = importlib.import_module("vne_simulator")
        importlib.import_module("vne_simulator.solver.learning.flag_vne")
        package_path = Path(package.__file__).resolve()
        if not is_within(package_path, flagvne_root):
            raise AdapterError(f"imported vne_simulator from {package_path}, outside {flagvne_root}")
        base = importlib.import_module("vne_simulator.base")
        data = importlib.import_module("vne_simulator.data")
        utils = importlib.import_module("vne_simulator.utils")
        required_exports = {
            "Config": getattr(package, "Config"),
            "REGISTRY": getattr(package, "REGISTRY"),
            "BasicScenario": getattr(base, "BasicScenario"),
            "Controller": getattr(base, "Controller"),
            "Counter": getattr(base, "Counter"),
            "Recorder": getattr(base, "Recorder"),
            "PhysicalNetwork": getattr(data, "PhysicalNetwork"),
            "VirtualNetwork": getattr(data, "VirtualNetwork"),
            "VirtualNetworkRequestSimulator": getattr(data, "VirtualNetworkRequestSimulator"),
            "get_v_nets_dataset_dir_from_setting": getattr(utils, "get_v_nets_dataset_dir_from_setting"),
        }
    except Exception as exc:
        raise AdapterError(
            "cannot import the pinned author implementation and its dependencies; "
            "install its requirements in the project 'virne' Conda environment"
        ) from exc
    return required_exports


def make_config(
    api: Mapping[str, Any],
    args: argparse.Namespace,
    *,
    phase: str,
    source_dir: Path,
    phase_root: Path,
) -> tuple[Any, Path, Path]:
    settings_dir = phase_root / "settings"
    catalog_dir = phase_root / "fixed_dataset_catalog"
    settings_dir.mkdir(parents=True, exist_ok=True)
    catalog_dir.mkdir(parents=True, exist_ok=True)
    source_vsim = load_yaml(source_dir / "v_sim_setting.yaml")
    vsim_setting = legacy_vsim_setting(source_vsim, catalog_dir / "v_nets")
    p_setting = pnet_setting(source_dir / "p_net.gml", catalog_dir / "p_net")
    vsim_path = settings_dir / "v_sim_setting.yaml"
    pnet_path = settings_dir / "p_net_setting.yaml"
    write_yaml(vsim_path, vsim_setting)
    write_yaml(pnet_path, p_setting)

    Config = api["Config"]
    with pushd(phase_root):
        config = Config(p_net_setting_path=str(pnet_path), v_sim_setting_path=str(vsim_path))
    run_id = args.run_id if phase == "eval" else f"{args.run_id}__train"
    config.update(
        {
            "solver_name": "flag_vne",
            "run_id": run_id,
            "seed": args.seed,
            "use_cuda": args.device == "cuda",
            "cuda_id": args.cuda_id,
            "distributed_training": False,
            "num_workers": 1,
            # Training is invoked directly below so that evaluation can use a
            # different fixed trace without reconstructing the policy.  Keep
            # the recorded author config faithful to the requested phase.
            "num_train_epochs": args.train_epochs if phase == "train" else 0,
            "num_epochs": args.eval_epochs if phase == "eval" else 1,
            "num_meta_learning_epochs": args.meta_train_epochs,
            "use_meta_learning": True,
            "use_bidirectional_action": True,
            "use_curriculum_scheduling_strategy": False,
            "infer_with_meta_policy": False,
            "batch_size": args.batch_size,
            "lr_actor": args.lr_actor,
            "lr_critic": args.lr_critic,
            "shortest_method": "k_shortest",
            "k_shortest": args.k_shortest,
            "allow_rejection": False,
            "renew_v_net_simulator": False,
            "pretrained_model_path": "",
            "if_save_records": True,
            "if_temp_save_records": True,
            "if_save_config": True,
            "save_dir": str(phase_root / "author_save"),
            "summary_dir": str(phase_root / "author_summary"),
            "summary_file_name": f"official_{phase}_summary.csv",
            "verbose": args.verbose,
        }
    )
    derived_dir = Path(api["get_v_nets_dataset_dir_from_setting"](config.v_sim_setting)).resolve()
    if not is_within(derived_dir, catalog_dir):
        raise AdapterError(f"author dataset helper escaped the cell runtime directory: {derived_dir}")
    prepare_legacy_payload(source_dir, derived_dir, config.v_sim_setting)
    config.p_net_dataset_dir = str(source_dir)
    config.v_nets_dataset_dir = str(derived_dir)
    config_name = f"{phase}_config.yaml"
    config.save(config_name)
    saved_config = Path(config.save_dir) / config.solver_name / config.run_id / config_name
    if not saved_config.is_file():
        raise AdapterError(f"author Config.save did not write {saved_config}")
    return config, derived_dir, saved_config


def make_environment(
    api: Mapping[str, Any],
    config: Any,
    source_dir: Path,
    legacy_dir: Path,
    Env: Any,
) -> tuple[Any, Any, Any, Any]:
    Counter = api["Counter"]
    Controller = api["Controller"]
    Recorder = api["Recorder"]
    PhysicalNetwork = api["PhysicalNetwork"]
    VirtualNetwork = api["VirtualNetwork"]
    VirtualNetworkRequestSimulator = api["VirtualNetworkRequestSimulator"]
    counter = Counter(
        config.v_sim_setting["node_attrs_setting"],
        config.v_sim_setting["link_attrs_setting"],
        **vars(config),
    )
    controller = Controller(
        config.v_sim_setting["node_attrs_setting"],
        config.v_sim_setting["link_attrs_setting"],
        **vars(config),
    )
    recorder = Recorder(counter, **vars(config))
    p_graph = read_compatible_gml(source_dir / "p_net.gml")
    p_net = PhysicalNetwork(incoming_graph_data=p_graph)
    p_net.check_attrs_existence()
    if graph_payload(p_net) != graph_payload(p_graph):
        raise AdapterError("author PhysicalNetwork conversion changed fixed node/edge payloads")
    p_net.degree_benchmark = p_net.get_degree_benchmark()
    p_net.node_attr_benchmarks = p_net.get_node_attr_benchmarks()
    p_net.link_attr_benchmarks = p_net.get_link_attr_benchmarks()
    p_net.link_sum_attr_benchmarks = p_net.get_link_sum_attr_benchmarks()

    v_setting = load_yaml(legacy_dir / "v_sim_setting.yaml")
    v_net_simulator = VirtualNetworkRequestSimulator.from_setting(v_setting)
    for v_net_path in sorted((legacy_dir / "v_nets").glob("v_net-*.gml")):
        v_graph = read_compatible_gml(v_net_path)
        v_net = VirtualNetwork(incoming_graph_data=v_graph)
        v_net.check_attrs_existence()
        if graph_payload(v_net) != graph_payload(v_graph):
            raise AdapterError(
                f"author VirtualNetwork conversion changed fixed payloads: {v_net_path}"
            )
        v_net_simulator.v_nets.append(v_net)
    v_net_simulator.events = load_yaml(legacy_dir / str(v_setting["events_file_name"]))
    v_net_simulator.construct_v2event_dict()
    if int(v_net_simulator.num_v_nets) != int(config.v_sim_setting["num_v_nets"]):
        raise AdapterError("author loader returned a different number of virtual networks")
    env = Env(p_net, v_net_simulator, controller, recorder, counter, **vars(config))
    return env, controller, recorder, counter


def require_attributes(owner: Any, expected: Mapping[str, Any], *, label: str) -> None:
    for name, value in expected.items():
        actual = getattr(owner, name, None)
        if actual != value:
            raise AdapterError(
                f"{label} {name} mismatch: expected {value!r}, found {actual!r}"
            )


def last_csv_row(path: Path) -> dict[str, str]:
    if not path.is_file():
        raise AdapterError(f"official summary was not written: {path}")
    with path.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    if not rows:
        raise AdapterError(f"official summary contains no rows: {path}")
    return rows[-1]


def finite_metric(row: Mapping[str, str], key: str, *, low: float | None = None, high: float | None = None) -> str:
    raw = row.get(key, "")
    try:
        value = float(raw)
    except (TypeError, ValueError) as exc:
        raise AdapterError(f"official summary has invalid {key}: {raw!r}") from exc
    if not math.isfinite(value) or (low is not None and value < low) or (high is not None and value > high):
        raise AdapterError(f"official summary has out-of-range {key}: {raw!r}")
    return str(raw)


def write_normalized_summary(
    args: argparse.Namespace,
    output_dir: Path,
    official_summary: Path,
    official_records: Sequence[Path],
    checkpoint: Path,
    dataset_tree_sha256: str,
    num_arrival_requests: int,
) -> dict[str, str]:
    source_row = last_csv_row(official_summary)
    acceptance = finite_metric(source_row, "acceptance_rate", low=0.0, high=1.0)
    r2c = finite_metric(source_row, "long_term_r2c_ratio", low=0.0)
    clock = finite_metric(source_row, "clock_running_time", low=0.0)
    success_count = source_row.get("success_count", "")
    if success_count == "":
        raise AdapterError("official summary is missing success_count")
    try:
        success_value = int(float(success_count))
    except (TypeError, ValueError) as exc:
        raise AdapterError(f"official summary has invalid success_count: {success_count!r}") from exc
    if abs(float(acceptance) - success_value / num_arrival_requests) > 1e-9:
        raise AdapterError("official acceptance_rate is inconsistent with success_count")
    row = {
        "solver_name": "flag_vne",
        "topology": args.topology,
        "scenario": args.scenario,
        "seed": str(args.seed),
        "k_shortest": str(args.k_shortest),
        "num_arrival_requests": str(num_arrival_requests),
        "num_train_epochs": str(args.train_epochs),
        "num_meta_learning_epochs": str(args.meta_train_epochs),
        "acceptance_rate": acceptance,
        "long_term_r2c_ratio": r2c,
        "clock_running_time": clock,
        "success_count": str(success_count),
        "run_id": args.run_id,
        "source_train_dataset_dir": str(resolved(args.train_dataset_dir)),
        "source_dataset_dir": str(resolved(args.eval_dataset_dir)),
        "dataset_tree_sha256": dataset_tree_sha256,
        "official_summary_path": relative_or_absolute(official_summary),
        "official_records_paths": ";".join(relative_or_absolute(path) for path in official_records),
        "checkpoint_path": relative_or_absolute(checkpoint),
        "upstream_commit": FLAGVNE_COMMIT,
        "status": "ok",
    }
    output_path = output_dir / "eval" / "summary.csv"
    with output_path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=NORMALIZED_FIELDS)
        writer.writeheader()
        writer.writerow(row)
    return row


def artifact_entries(output_dir: Path, paths: Sequence[Path]) -> list[dict[str, Any]]:
    entries = []
    for path in sorted({resolved(item) for item in paths}):
        if not path.is_file():
            raise AdapterError(f"expected artifact is missing: {path}")
        entries.append(file_entry(path, base=output_dir))
    return entries


def run_cell(args: argparse.Namespace) -> int:
    if args.train_dataset_dir is None or args.eval_dataset_dir is None or args.output_dir is None:
        raise AdapterError("cell requires --train-dataset, --test-dataset, and --output-dir")
    args.train_dataset_dir = resolved(args.train_dataset_dir)
    args.eval_dataset_dir = resolved(args.eval_dataset_dir)
    args.output_dir = resolved(args.output_dir)
    if is_within(args.train_dataset_dir, args.output_dir) or is_within(args.eval_dataset_dir, args.output_dir):
        raise AdapterError("output directory cannot contain either source dataset")
    if args.output_dir.exists() and any(args.output_dir.iterdir()):
        existing_manifest = args.output_dir / "manifest.json"
        if args.overwrite:
            shutil.rmtree(args.output_dir)
        elif existing_manifest.is_file():
            existing = json.loads(existing_manifest.read_text(encoding="utf-8"))
            if existing.get("status") == "complete":
                validate_completed_run(args)
                print(args.output_dir / "eval" / "summary.csv")
                print(existing_manifest)
                return 0
            shutil.rmtree(args.output_dir)
        else:
            raise AdapterError(
                f"nonempty output has no adapter manifest (use --overwrite explicitly): {args.output_dir}"
            )
    args.output_dir.mkdir(parents=True, exist_ok=True)
    manifest_path = args.output_dir / "manifest.json"
    manifest: dict[str, Any] = {
        "schema_version": 1,
        "status": "running",
        "started_at": utc_now(),
        "adapter": relative_or_absolute(Path(__file__)),
        "cell": {
            "run_id": args.run_id,
            "topology": args.topology,
            "scenario": args.scenario,
            "seed": args.seed,
        },
        "parameters": {
            "train_epochs": args.train_epochs,
            "meta_train_epochs": args.meta_train_epochs,
            "eval_epochs": args.eval_epochs,
            "batch_size": args.batch_size,
            "lr_actor": args.lr_actor,
            "lr_critic": args.lr_critic,
            "k_shortest": args.k_shortest,
            "use_meta_learning": True,
            "use_bidirectional_action": True,
            "use_curriculum_scheduling_strategy": False,
            "infer_with_meta_policy": False,
            "device_requested": args.device,
            "cuda_id": args.cuda_id,
        },
    }
    write_json(manifest_path, manifest)
    try:
        pf = preflight(args)
        manifest["upstream"] = pf["upstream"]
        manifest["datasets"] = pf["datasets"]
        if args.device == "cuda":
            # The author code hardcodes cuda:0.  CUDA_VISIBLE_DEVICES makes the
            # requested physical GPU appear as device zero before torch import.
            os.environ["CUDA_VISIBLE_DEVICES"] = str(args.cuda_id)
        api = import_author_api(args.flagvne_root)
        solver_info = api["REGISTRY"].get("flag_vne")
        if not isinstance(solver_info, Mapping) or "env" not in solver_info or "solver" not in solver_info:
            raise AdapterError("author registry does not expose the full flag_vne env/solver pair")
        Env, Solver = solver_info["env"], solver_info["solver"]

        train_root = args.output_dir / "train"
        eval_root = args.output_dir / "eval"
        train_root.mkdir()
        eval_root.mkdir()
        train_config, train_legacy, train_saved_config = make_config(
            api, args, phase="train", source_dir=args.train_dataset_dir, phase_root=train_root
        )
        require_attributes(
            train_config,
            {
                "solver_name": "flag_vne",
                "seed": args.seed,
                "num_train_epochs": args.train_epochs,
                "num_meta_learning_epochs": args.meta_train_epochs,
                "use_meta_learning": True,
                "use_bidirectional_action": True,
                "use_curriculum_scheduling_strategy": False,
                "infer_with_meta_policy": False,
                "shortest_method": "k_shortest",
                "k_shortest": args.k_shortest,
            },
            label="training config",
        )
        train_env, train_controller, train_recorder, train_counter = make_environment(
            api, train_config, args.train_dataset_dir, train_legacy, Env
        )
        solver = Solver(train_controller, train_recorder, train_counter, **vars(train_config))
        require_attributes(
            solver,
            {
                "use_meta_learning": True,
                "use_bidirectional_action": True,
                "use_curriculum_scheduling_strategy": False,
                "infer_with_meta_policy": False,
                "num_meta_learning_epochs": args.meta_train_epochs,
            },
            label="official solver",
        )
        if args.device == "cuda" and not getattr(solver, "use_cuda", False):
            raise AdapterError("CUDA was requested, but the official solver fell back to CPU")
        solver.learn(train_env, num_epochs=args.train_epochs)
        checkpoint_name = "official_flag_vne_cell.pkl"
        solver.save_model(checkpoint_name)
        checkpoint = Path(solver.model_dir) / checkpoint_name
        if not checkpoint.is_file() or checkpoint.stat().st_size == 0:
            raise AdapterError(f"official solver did not save its checkpoint: {checkpoint}")

        eval_config, eval_legacy, eval_saved_config = make_config(
            api, args, phase="eval", source_dir=args.eval_dataset_dir, phase_root=eval_root
        )
        require_attributes(
            eval_config,
            {
                "solver_name": "flag_vne",
                "seed": args.seed,
                "num_train_epochs": 0,
                "num_meta_learning_epochs": args.meta_train_epochs,
                "shortest_method": "k_shortest",
                "k_shortest": args.k_shortest,
            },
            label="evaluation config",
        )
        eval_env, eval_controller, eval_recorder, eval_counter = make_environment(
            api, eval_config, args.eval_dataset_dir, eval_legacy, Env
        )
        # Reuse the trained object in this process.  FlagVNE constructs each
        # instance environment from these references in solve().
        solver.controller = eval_controller
        solver.recorder = eval_recorder
        solver.counter = eval_counter
        solver.eval()
        scenario = api["BasicScenario"](eval_env, solver, eval_config)
        scenario.run()

        official_summary = Path(eval_config.summary_dir) / eval_config.summary_file_name
        record_dir = Path(eval_recorder.record_dir)
        official_records = sorted(
            path for path in record_dir.glob("*.csv") if not path.name.startswith("temp-")
        )
        if not official_records:
            raise AdapterError(f"official recorder wrote no final record CSV in {record_dir}")
        normalized_row = write_normalized_summary(
            args,
            args.output_dir,
            official_summary,
            official_records,
            checkpoint,
            manifest["datasets"]["eval"]["tree_sha256"],
            int(manifest["datasets"]["eval"]["num_v_nets"]),
        )
        artifact_paths = [
            official_summary,
            checkpoint,
            args.output_dir / "eval" / "summary.csv",
            train_root / "settings" / "p_net_setting.yaml",
            train_root / "settings" / "v_sim_setting.yaml",
            eval_root / "settings" / "p_net_setting.yaml",
            eval_root / "settings" / "v_sim_setting.yaml",
            train_saved_config,
            eval_saved_config,
            *official_records,
        ]
        manifest.update(
            {
                "status": "complete",
                "finished_at": utc_now(),
                "device_effective": str(getattr(solver, "device", "unknown")),
                "checkpoint": file_entry(checkpoint),
                "normalized_result": normalized_row,
                "artifacts": artifact_entries(args.output_dir, artifact_paths),
                "limitations": [
                    "The upstream tree has no stated license; this adapter references a local checkout and does not vendor it.",
                    "The authors publish no pretrained FlagVNE checkpoint, so every cell trains before evaluation.",
                    "The official policy fixes the physical-node count; train and evaluation datasets must have equal counts.",
                    "The legacy loader requires a storage-metadata view. GML and event payloads remain byte-identical symlinks; quoted GML Boolean metadata is normalized in memory and node/edge payload equality is checked.",
                    "Official wall-clock time includes evaluation only and remains hardware dependent.",
                ],
            }
        )
        write_json(manifest_path, manifest)
    except Exception as exc:
        manifest.update(
            {
                "status": "failed",
                "finished_at": utc_now(),
                "error_type": type(exc).__name__,
                "error": str(exc),
                "traceback": traceback.format_exc(),
            }
        )
        write_json(manifest_path, manifest)
        raise
    print(args.output_dir / "eval" / "summary.csv")
    print(manifest_path)
    return 0


def validate_completed_run(args: argparse.Namespace) -> dict[str, Any]:
    output_dir = resolved(args.output_dir)
    manifest_path = output_dir / "manifest.json"
    if not manifest_path.is_file():
        raise AdapterError(f"missing run manifest: {manifest_path}")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    if manifest.get("status") != "complete":
        raise AdapterError(f"run is not complete: status={manifest.get('status')!r}")
    if manifest.get("upstream", {}).get("commit") != FLAGVNE_COMMIT:
        raise AdapterError("manifest does not name the pinned FlagVNE commit")
    checkout_info(args.flagvne_root)
    cell = manifest.get("cell", {})
    expected_cell = {
        "run_id": args.run_id,
        "topology": args.topology,
        "scenario": args.scenario,
        "seed": args.seed,
    }
    for key, expected in expected_cell.items():
        if cell.get(key) != expected:
            raise AdapterError(f"manifest {key} mismatch: expected {expected!r}, found {cell.get(key)!r}")
    parameters = manifest.get("parameters", {})
    expected_parameters = {
        "train_epochs": args.train_epochs,
        "meta_train_epochs": args.meta_train_epochs,
        "eval_epochs": args.eval_epochs,
        "batch_size": args.batch_size,
        "lr_actor": args.lr_actor,
        "lr_critic": args.lr_critic,
        "k_shortest": args.k_shortest,
        "use_meta_learning": True,
        "use_bidirectional_action": True,
        "use_curriculum_scheduling_strategy": False,
        "infer_with_meta_policy": False,
        "device_requested": args.device,
        "cuda_id": args.cuda_id,
    }
    for key, expected in expected_parameters.items():
        if parameters.get(key) != expected:
            raise AdapterError(
                f"manifest parameter {key} mismatch: expected {expected!r}, "
                f"found {parameters.get(key)!r}"
            )
    datasets = manifest.get("datasets", {})
    if resolved(Path(datasets.get("train", {}).get("path", "."))) != resolved(args.train_dataset_dir):
        raise AdapterError("manifest train dataset mismatch")
    if resolved(Path(datasets.get("eval", {}).get("path", "."))) != resolved(args.eval_dataset_dir):
        raise AdapterError("manifest evaluation dataset mismatch")
    current_datasets = preflight(args)["datasets"]
    for split in ("train", "eval"):
        if current_datasets[split]["tree_sha256"] != datasets.get(split, {}).get("tree_sha256"):
            raise AdapterError(f"source {split} dataset changed after the cell ran")
    artifacts = manifest.get("artifacts")
    if not isinstance(artifacts, list) or not artifacts:
        raise AdapterError("manifest has no artifact inventory")
    for entry in artifacts:
        path = output_dir / entry["path"]
        if not path.is_file():
            raise AdapterError(f"manifest artifact is missing: {path}")
        if path.stat().st_size != int(entry["size_bytes"]):
            raise AdapterError(f"artifact size changed: {path}")
        if sha256_file(path) != entry["sha256"]:
            raise AdapterError(f"artifact digest changed: {path}")
    normalized = output_dir / "eval" / "summary.csv"
    row = last_csv_row(normalized)
    try:
        row_seed = int(float(row.get("seed", -1)))
        row_k = int(float(row.get("k_shortest", -1)))
        arrivals = int(float(row.get("num_arrival_requests", -1)))
        successes = int(float(row.get("success_count", -1)))
        acceptance = float(row.get("acceptance_rate", "nan"))
        r2c = float(row.get("long_term_r2c_ratio", "nan"))
        clock = float(row.get("clock_running_time", "nan"))
    except (TypeError, ValueError) as exc:
        raise AdapterError("normalized summary has malformed numeric fields") from exc
    eval_dataset = datasets.get("eval", {})
    if (
        row.get("status") != "ok"
        or row.get("upstream_commit") != FLAGVNE_COMMIT
        or row.get("solver_name") != "flag_vne"
        or row.get("run_id") != args.run_id
        or row_seed != args.seed
        or row_k != args.k_shortest
        or arrivals != int(eval_dataset.get("num_v_nets", -1))
        or row.get("dataset_tree_sha256") != eval_dataset.get("tree_sha256")
        or resolved(Path(row.get("source_train_dataset_dir", ".")))
        != resolved(args.train_dataset_dir)
        or resolved(Path(row.get("source_dataset_dir", "."))) != resolved(args.eval_dataset_dir)
        or successes < 0
        or successes > arrivals
        or not math.isfinite(acceptance)
        or abs(acceptance - successes / arrivals) > 1e-9
        or not math.isfinite(r2c)
        or r2c < 0.0
        or not math.isfinite(clock)
        or clock < 0.0
    ):
        raise AdapterError("normalized summary provenance/status is invalid")
    return {
        "schema_version": 1,
        "status": "validation_ok",
        "checked_at": utc_now(),
        "output_dir": str(output_dir),
        "artifact_count": len(artifacts),
        "upstream_commit": FLAGVNE_COMMIT,
    }


def positive_int(value: str) -> int:
    parsed = int(value)
    if parsed <= 0:
        raise argparse.ArgumentTypeError("must be positive")
    return parsed


def safe_run_id(value: str) -> str:
    if not re.fullmatch(r"[A-Za-z0-9_.-]+", value):
        raise argparse.ArgumentTypeError("use only letters, digits, dot, underscore, and dash")
    return value


def add_cell_arguments(parser: argparse.ArgumentParser, *, output_required: bool = True) -> None:
    parser.add_argument(
        "--source-dir",
        "--flagvne-root",
        dest="flagvne_root",
        type=Path,
        required=True,
        help="Pinned, clean checkout of GeminiLight/flag-vne.",
    )
    parser.add_argument(
        "--train-dataset",
        "--train-dataset-dir",
        dest="train_dataset_dir",
        type=Path,
        required=True,
    )
    parser.add_argument(
        "--test-dataset",
        "--eval-dataset-dir",
        dest="eval_dataset_dir",
        type=Path,
        required=True,
    )
    parser.add_argument("--output-dir", type=Path, required=output_required)
    parser.add_argument("--topology", required=True)
    parser.add_argument("--scenario", default="nominal")
    parser.add_argument("--seed", type=int, required=True)
    parser.add_argument("--train-epochs", type=positive_int, default=100)
    parser.add_argument("--meta-train-epochs", type=int, default=0)
    parser.add_argument("--eval-epochs", type=positive_int, default=1)
    parser.add_argument("--batch-size", type=positive_int, default=128)
    parser.add_argument("--lr-actor", type=float, default=0.001)
    parser.add_argument("--lr-critic", type=float, default=0.001)
    parser.add_argument("--k-shortest", type=positive_int, default=10)
    parser.add_argument("--device", choices=("cpu", "cuda"), default="cuda")
    parser.add_argument("--cuda-device", "--cuda-id", dest="cuda_id", type=int, default=0)
    parser.add_argument("--run-id", type=safe_run_id, required=True)
    parser.add_argument("--verbose", type=int, choices=(0, 1, 2), default=1)
    parser.add_argument("--overwrite", action="store_true")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)
    cell = subparsers.add_parser("cell", help="Train and evaluate one fixed-data cell.")
    add_cell_arguments(cell)
    validate = subparsers.add_parser("validate-cell", help="Validate a completed cell and its digests.")
    add_cell_arguments(validate)
    check = subparsers.add_parser("preflight", help="Validate the source checkout and fixed datasets only.")
    add_cell_arguments(check, output_required=False)
    check.add_argument("--preflight-json", type=Path)
    args = parser.parse_args()
    if args.meta_train_epochs < 0 or args.meta_train_epochs > args.train_epochs:
        parser.error("--meta-train-epochs must be between zero and --train-epochs")
    if args.cuda_id < 0:
        parser.error("--cuda-id must be nonnegative")
    if args.lr_actor <= 0 or args.lr_critic <= 0:
        parser.error("learning rates must be positive")
    return args


def main() -> int:
    args = parse_args()
    args.flagvne_root = resolved(args.flagvne_root)
    if args.command == "preflight":
        report = preflight(args)
        text = json.dumps(report, indent=2, sort_keys=True) + "\n"
        if args.preflight_json is not None:
            write_json(resolved(args.preflight_json), report)
            print(resolved(args.preflight_json))
        else:
            print(text, end="")
        return 0
    if args.command == "validate-cell":
        print(json.dumps(validate_completed_run(args), indent=2, sort_keys=True))
        return 0
    return run_cell(args)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except AdapterError as exc:
        print(f"flagvne adapter error: {exc}", file=sys.stderr)
        raise SystemExit(2)
