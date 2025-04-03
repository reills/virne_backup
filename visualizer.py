import os
import networkx as nx
import matplotlib.pyplot as plt
import pandas as pd
import ast
from matplotlib.widgets import Button
from collections import defaultdict
import re


# ------------------------------------------------------------------------------
# 1) Paths & CSV
# ------------------------------------------------------------------------------
#v_path = "/Users/stephenreilly/Desktop/github/virne/save/sa/Stephens-MacBook-Pro-2.local-20250226T193311/records"
#v_csv_filename = "/sa-Stephens-MacBook-Pro-2.local-20250226T193311-20250226T193311.csv"
v_path = "/Users/stephenreilly/Desktop/github/virne/dataset/results-visualizer/"
v_csv_filename ="sa-20250402T013438.csv"
df = pd.read_csv(v_path + v_csv_filename)

#p_path = "/Users/stephenreilly/Desktop/github/virne/dataset/p_net/10-waxman_[0.5-0.2]-cpu_[50-100]-max_cpu_None-bw_[50-100]-max_bw_None/p_net.gml"
p_path = "/Users/stephenreilly/Desktop/github/virne/dataset/results-visualizer/p_net.gml"
physical_graph = nx.read_gml(p_path)
physical_graph = nx.relabel_nodes(physical_graph, lambda x: str(x))

SFC_FOLDER_PATH = (
    #"/Users/stephenreilly/Desktop/github/virne/dataset/v_nets/100-[4-4]-random-500-0.04-cpu_[0-50]-bw_[0-50]/v_nets/"
    "/Users/stephenreilly/Desktop/github/virne/dataset/results-visualizer/v_nets"
)

def get_vnet_gml_path(row_index):
    return os.path.join(SFC_FOLDER_PATH, f"v_net-{row_index:05d}.gml")

# ------------------------------------------------------------------------------
# 2) CSV Column Names (adjust if needed)
# ------------------------------------------------------------------------------
V_NET_ID = "v_net_id"
DESCRIPTION_COL = "description"
ARRIVAL_COL     = "v_net_arrival_time"
LIFETIME_COL    = "v_net_lifetime"
EVENT_TIME_COL  = "event_time"
NODE_SLOTS_COL  = "node_slots"
LINK_PATHS_COL  = "link_paths"
RESULT          = "result"

df[NODE_SLOTS_COL] = df[NODE_SLOTS_COL].str.replace(
    r'np\.int64\((\d+)\)', r'\1', regex=True
)
df[LINK_PATHS_COL] = df[LINK_PATHS_COL].str.replace(
    r'np\.int64\((\d+)\)', r'\1', regex=True
)


# ------------------------------------------------------------------------------
# Matplotlib Figure & Global Row Index
# ------------------------------------------------------------------------------
fig, ax = plt.subplots(figsize=(12, 8))
plt.subplots_adjust(left=0.05, right=0.95, top=0.92, bottom=0.08)  # Make graph taller, reduce bottom gap

current_index = 0

# ------------------------------------------------------------------------------
# 3) Helpers to parse CSV row data & read GML
# ------------------------------------------------------------------------------
def parse_graph_data(row):
    """
    Safely parse node_slots/link_paths, converting keys to strings.
    """
    node_slots_str = row.get(NODE_SLOTS_COL, None)
    link_paths_str = row.get(LINK_PATHS_COL, None)

    node_slots = ast.literal_eval(node_slots_str) if pd.notna(node_slots_str) else {}
    link_paths = ast.literal_eval(link_paths_str) if pd.notna(link_paths_str) else {}

    node_slots = {str(vn): str(pn) for vn, pn in node_slots.items()}

    fixed_link_paths = {}
    for (vsrc, vdst), ppath in link_paths.items():
        vsrc_str, vdst_str = str(vsrc), str(vdst)
        ppath_strs = [str(x) for x in ppath]
        fixed_link_paths[(vsrc_str, vdst_str)] = ppath_strs

    return node_slots, fixed_link_paths


def load_vnet_demands(row_index):
    """
    Read GML for row_index to get node/edge demands.
    """
    path = get_vnet_gml_path(row_index)
    node_demands = {}
    edge_demands = {}
    if os.path.isfile(path):
        G = nx.read_gml(path)
        for n, data in G.nodes(data=True):
            node_demands[str(n)] = dict(data)
        for u, v, data in G.edges(data=True):
            edge_demands[(str(u), str(v))] = dict(data)
            edge_demands[(str(v), str(u))] = dict(data)  # Undirected
    return node_demands, edge_demands

# ------------------------------------------------------------------------------
# 4) Compute active vNets
# ------------------------------------------------------------------------------
def compute_active_vnets_upto(index):
    """
    Rebuild active vNets from row 0..index (inclusive).
    """
    active_vnets = {}
    for i in range(index + 1):
        row = df.iloc[i]
        desc = str(row[DESCRIPTION_COL]).strip()
        successful_placement = str(row[RESULT]).strip()
        event_t = round(float(row[EVENT_TIME_COL]))

        to_remove = []
        for vid, data in active_vnets.items():
            if event_t >= round(data["arrival_time"] + data["lifetime"]) or data.get("expired", False):
                to_remove.append(vid)
        for vid in to_remove:
            active_vnets.pop(vid, None)

        if successful_placement == "True":
            vnet_id = int(row[V_NET_ID])
            arrival = round(float(row[ARRIVAL_COL]), 1)
            life = round(float(row[LIFETIME_COL]), 1)

            nslots, lpaths = parse_graph_data(row)
            active_vnets[vnet_id] = {
                "arrival_time": arrival,
                "lifetime": life,
                "node_slots": nslots,
                "link_paths": lpaths,
                "allocated_row": i,
                "expired": False
            }

        elif desc == "Leave Event":
             vnet_id = int(row[V_NET_ID])
             if vnet_id in active_vnets:
                active_vnets[vnet_id]["expired"] = True

    final_event_t = round(float(df.iloc[index][EVENT_TIME_COL]), 1)
    to_remove = []
    for vid, data in active_vnets.items():
        if final_event_t >= (data["arrival_time"] + data["lifetime"]) or data.get("expired", False):
            to_remove.append(vid)
    for vid in to_remove:
        active_vnets.pop(vid, None)

    return active_vnets

# ------------------------------------------------------------------------------
# A) Accumulate usage on each pNode (like CPU, etc.)
# ------------------------------------------------------------------------------
def accumulate_physical_node_usage(active_vnets):
    """
    Returns usage_dict, where usage_dict[p_node][resource_key] = total usage
    """
    usage_dict = defaultdict(lambda: defaultdict(float))
    
    for vnet_id, data in active_vnets.items():
        node_demands, _ = load_vnet_demands(vnet_id)
        for v_node, p_node in data["node_slots"].items():
            vnode_attrs = node_demands.get(v_node, {})
            for k, v in vnode_attrs.items():
                k_lower = k.lower()
                if k_lower not in ["id", "label", "pos"] and "max" not in k_lower:
                    try:
                        val_float = float(v)
                        usage_dict[p_node][k] += val_float
                    except (ValueError, TypeError):
                        pass
    return usage_dict

# ------------------------------------------------------------------------------
# B) Gather which (vNet, vNode) pairs are mapped to each pNode
# ------------------------------------------------------------------------------
def gather_pnode_to_sfc(active_vnets):
    """
    Returns: pnode_to_sfc[p_node] = list of (vnet_id, v_node)
    """
    pnode_to_sfc = defaultdict(list)
    for vnet_id, data in active_vnets.items():
        for v_node, p_node in data["node_slots"].items():
            pnode_to_sfc[p_node].append((vnet_id, v_node))
    return pnode_to_sfc

# ------------------------------------------------------------------------------
# C) Accumulate bandwidth usage on each physical edge
# ------------------------------------------------------------------------------
def accumulate_physical_edge_bw_usage(active_vnets):
    """
    Calculates total BW usage on each physical edge.  Handles undirected graphs.
    """
    edge_bw_usage = defaultdict(float)

    for vnet_id, data in active_vnets.items():
        _, edge_demands = load_vnet_demands(vnet_id)

        for (vsrc, vdst), path_nodes in data["link_paths"].items():
            demanded_bw = 0.0
            if (vsrc, vdst) in edge_demands:
                demanded_bw = float(edge_demands[(vsrc, vdst)].get('bw', 0.0))
            elif (vdst, vsrc) in edge_demands:
                demanded_bw = float(edge_demands[(vdst, vsrc)].get('bw', 0.0))

            for raw_value in path_nodes:
                raw_value = raw_value.strip()
                tuple_matches = re.findall(r"\((\d+),\s*(\d+)\)", raw_value)
                for match in tuple_matches:
                    e1, e2 = match
                    key_u, key_v = sorted([int(e1), int(e2)])
                    edge_bw_usage[(str(key_u), str(key_v))] += demanded_bw

    return edge_bw_usage

# ------------------------------------------------------------------------------
# D) Build the node label (MODIFIED FOR FONT SIZE AND SFC FORMAT)
# ------------------------------------------------------------------------------
def build_physical_node_label(p_node, node_usage_dict, pnode_to_sfc):
    """
    Builds node label: Node ID, resource usage, SFC info.
    """
    lines = [f"Node {p_node}"]

    used_resources = node_usage_dict.get(p_node, {})
    pnode_attrs = physical_graph.nodes[p_node]

    for attr, capacity in pnode_attrs.items():
        attr_lower = attr.lower()
        if attr_lower in ["id", "label", "pos"] or "max" in attr_lower:
            continue
        try:
            capacity_val = float(capacity)
            used_val = float(used_resources.get(attr, 0.0))
        except (ValueError, TypeError):
            continue

        lines.append(f"{attr.upper()} {int(used_val)}/{int(capacity_val)}")

    sfc_info = pnode_to_sfc[p_node]
    if sfc_info:
        sfc_info_sorted = sorted(sfc_info, key=lambda x: int(x[0]))
        # MODIFIED: Use "vID: vNode" format
        sfc_parts = [f"{vnet_id}|{vnode}" for (vnet_id, vnode) in sfc_info_sorted]
        lines.append("vID: " + ", ".join(sfc_parts))  # MODIFIED: Changed label

    return "\n".join(lines)

# ------------------------------------------------------------------------------
# E) Build the edge label for bandwidth usage
# ------------------------------------------------------------------------------
def build_physical_edge_label(u, v, used_bw):
    """
    Builds edge label like "BW 25/80".  Handles undirected graphs.
    """
    if physical_graph.has_edge(u, v):
        e_data = physical_graph[u][v]
    elif physical_graph.has_edge(v, u):
        e_data = physical_graph[v][u]
    else:
        return "BW 0/0"

    capacity_val = e_data.get('max_bw', e_data.get('bw', 0.0))
    try:
        capacity_val = float(capacity_val)
    except (ValueError, TypeError):
        capacity_val = 0.0

    return f"BW {int(used_bw)}/{int(capacity_val)}"

# ------------------------------------------------------------------------------
# F) Initialize node usage
# ------------------------------------------------------------------------------
def initialize_node_usage():
    """
    Creates an initial node usage dictionary with 0 usage for all resources.
    """
    usage_dict = defaultdict(lambda: defaultdict(float))
    for p_node in physical_graph.nodes():
        for attr, capacity in physical_graph.nodes[p_node].items():
            attr_lower = attr.lower()
            if attr_lower not in ["id", "label", "pos"] and "max" not in attr_lower:
                try:
                    float(capacity)
                    usage_dict[p_node][attr] = 0.0
                except (ValueError, TypeError):
                    pass
    return usage_dict

# ------------------------------------------------------------------------------
# G) Initialize edge bandwidth usage
# ------------------------------------------------------------------------------

def initialize_edge_bw_usage():
    """
    Creates initial edge bandwidth usage with 0 for all edges
    """
    edge_bw_usage = defaultdict(float)
    for u, v in physical_graph.edges():
        key_u, key_v = sorted([int(u), int(v)])
        edge_bw_usage[(str(key_u), str(key_v))] = 0.0
    return edge_bw_usage
# ------------------------------------------------------------------------------
# 5) Drawing Logic
# ------------------------------------------------------------------------------
def draw_graph(index):
    global current_index
    current_index = index
    ax.clear()

    # Use Kamada-Kawai layout
    pos = nx.kamada_kawai_layout(physical_graph)

    active_vnets = compute_active_vnets_upto(index)
    node_usage_dict = initialize_node_usage()
    node_usage_dict.update(accumulate_physical_node_usage(active_vnets))
    pnode_to_sfc = gather_pnode_to_sfc(active_vnets)
    edge_bw_usage = initialize_edge_bw_usage()
    edge_bw_usage.update(accumulate_physical_edge_bw_usage(active_vnets))

    # --- Node Coloring (NOW APPLIED TO LABELS) ---
    newly_allocated = [vid for vid, d in active_vnets.items() if d["allocated_row"] == index]
    node_color_map = {}  # p_node -> color

    for vnet_id, data in active_vnets.items():
        color = "palegreen" if (vnet_id in newly_allocated) else "lightcyan"
        for v_node, p_node in data["node_slots"].items():
            node_color_map[p_node] = color

    # --- Draw Nodes (all lightgray) ---
    nx.draw_networkx_nodes(physical_graph, pos, node_color="lightgray", node_size=600, ax=ax)

    # --- Edge Coloring ---
    edges_to_draw = defaultdict(list)
    for vnet_id, data in active_vnets.items():
        color = "palegreen" if (vnet_id in newly_allocated) else "lightcyan"  # Consistent colors
        for (vsrc, vdst), path_nodes in data["link_paths"].items():
            for raw_value in path_nodes:
                raw_value = raw_value.strip()
                tuple_matches = re.findall(r"\((\d+),\s*(\d+)\)", raw_value)
                for match in tuple_matches:
                    e1, e2 = match
                    if physical_graph.has_edge(e1, e2) or physical_graph.has_edge(e2, e1):
                        edges_to_draw[color].append((e1, e2))

    # Draw *all* edges first in gray, then overlay colored edges
    nx.draw_networkx_edges(physical_graph, pos, edge_color="gray", alpha=0.5, width=1.5, ax=ax)
    for color, edge_list in edges_to_draw.items():
        color = "lime" if color == "palegreen" else "dodgerblue"
        nx.draw_networkx_edges(physical_graph, pos, edgelist=edge_list, edge_color= color, width=4, ax=ax)

    # --- Labels (COLORED BACKGROUNDS) ---
    node_labels = {n: build_physical_node_label(n, node_usage_dict, pnode_to_sfc) for n in physical_graph.nodes()}

    # Iterate through nodes and draw labels *individually* with correct colors
    for p_node in physical_graph.nodes():
        label_color = node_color_map.get(p_node, "white")  # Default to white if no mapping
        nx.draw_networkx_labels(
            physical_graph,
            pos,
            labels={p_node: node_labels[p_node]},  # Draw only *one* label at a time
            font_size=8,
            font_weight="bold",
            font_color="black",
            bbox=dict(
                facecolor=label_color,  # Use the determined color
                edgecolor="black",
                boxstyle="round,pad=0.3"
            ),
            ax=ax
        )


    edge_labels = {}
    for (u, v), used_bw in edge_bw_usage.items():
        edge_labels[(u, v)] = build_physical_edge_label(u, v, used_bw)
    nx.draw_networkx_edge_labels(
        physical_graph,
        pos,
        edge_labels=edge_labels,
        font_size=8,
        font_color="blue",
        bbox=dict(facecolor="white", edgecolor="none", alpha=0.7),
        ax=ax
    )

    # --- Title ---
    row = df.iloc[index]
    event_time = round(float(row[EVENT_TIME_COL]), 1)
    ax.set_title(
        #f"Row {index+1}/{len(df)} | "
        f"Event Time={event_time} | "
        f"Description={row[DESCRIPTION_COL]}",
        fontsize=14, fontweight="bold"
    )

    # --- VNet Info Display ---
    row = df.iloc[index]
    if row[RESULT] == True:  # Only display if successful
        vnet_id = int(row[V_NET_ID])
        node_demands, _ = load_vnet_demands(vnet_id)

        # Build a multi-line string. First line: vNet ID
        lines = [f"vNet: {vnet_id}"]

        # Then each virtual node on its own line
        for v_node, demands in node_demands.items():
            # Gather relevant demands
            demand_strs = []
            for resource, value in demands.items():
                resource_lower = resource.lower()
                # Exclude attributes you don't want to display, like 'ID', 'pos', or 'max' fields
                if resource_lower not in ["id", "label", "pos"] and "max" not in resource_lower:
                    try:
                        float(value)
                        demand_strs.append(f"{resource.upper()} {value}")
                    except ValueError:
                        pass

            # Join the demands into something like: "CPU 30, GPU 4, ROM 2" 
            demand_part = ", ".join(demand_strs)
            # Add a line like "**vID 3**: CPU 30, GPU 4, ROM 2"
            lines.append(f"vNode ID {v_node}: {demand_part}")

        # Combine all lines with newlines
        vnet_info_text = "\n".join(lines)

        # Place text at the bottom (y ~ 0.05) and center (x=0.5)
        # Use a partially transparent bbox so we can see the graph behind the text.
        ax.text(
            #0.5, 0.04,                  # X, Y in axes coordinates
            0.7, 0.8, 
            vnet_info_text,
            transform=ax.transAxes,
            ha="center", 
            va="bottom",
            fontsize=10, 
            family="monospace",
            bbox=dict(
                facecolor="white", 
                alpha=0.8, 
                boxstyle="round,pad=0.3", 
                edgecolor="gray"
            )
        )

    plt.draw()



# ------------------------------------------------------------------------------
# 6) Button Callbacks
# ------------------------------------------------------------------------------
def next_graph(event):
    global current_index
    current_index = (current_index + 1) % len(df)
    draw_graph(current_index)

def prev_graph(event):
    global current_index
    current_index = (current_index - 1) % len(df)
    draw_graph(current_index)

# ------------------------------------------------------------------------------
# 7) Initialize & Show
# ------------------------------------------------------------------------------
draw_graph(current_index)

# --- Move and Resize Buttons (Closer to Bottom) ---
button_width = 0.08  
button_height = 0.04  # Reduce height even more
button_spacing = 0.01  

axprev = plt.axes([0.85 - button_width - button_spacing, 0.01, button_width, button_height])  # Shift lower
axnext = plt.axes([0.85, 0.01, button_width, button_height])  # Shift lower
bnext = Button(axnext, "Next")
bprev = Button(axprev, "Previous")
bnext.on_clicked(next_graph)
bprev.on_clicked(prev_graph)

plt.show()