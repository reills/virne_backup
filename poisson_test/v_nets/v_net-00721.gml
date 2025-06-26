graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 721
  arrival_time 15259.710890897142
  lifetime 2024.10182789712
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 25
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 40
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 39
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
]
