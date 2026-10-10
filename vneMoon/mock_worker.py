#!/usr/bin/env python3
"""Short deterministic workers used only by `moon.py self-test`."""
from __future__ import annotations

import argparse
import json
import os
import socket
import time
from pathlib import Path


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("mode", choices=("codex", "experiment"))
    parser.add_argument("--output", required=True)
    parser.add_argument("--marker", default="")
    parser.add_argument("--sleep", type=float, default=0.15)
    args = parser.parse_args()
    output = Path(args.output)
    output.parent.mkdir(parents=True, exist_ok=True)

    if args.mode == "codex":
        time.sleep(args.sleep)
        output.write_text(
            json.dumps({"kind": "mock_codex", "pid": os.getpid(), "marker": args.marker}) + "\n",
            encoding="utf-8",
        )
        return 0

    codex_alive = False
    marker = args.marker.encode()
    if marker:
        for environ_path in Path("/proc").glob("[0-9]*/environ"):
            try:
                if marker in environ_path.read_bytes():
                    codex_alive = True
                    break
            except (OSError, PermissionError):
                continue

    network_blocked = False
    sock = socket.socket()
    sock.settimeout(0.2)
    try:
        sock.connect(("1.1.1.1", 53))
    except OSError:
        network_blocked = True
    finally:
        sock.close()
    time.sleep(args.sleep)
    output.write_text(
        json.dumps(
            {
                "kind": "mock_experiment",
                "pid": os.getpid(),
                "codex_alive": codex_alive,
                "network_blocked": network_blocked,
                "llm_forbidden": os.environ.get("VNEMOON_LLM_FORBIDDEN") == "1",
            }
        )
        + "\n",
        encoding="utf-8",
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

