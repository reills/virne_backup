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
  id 1002
  arrival_time 21442.505840173144
  lifetime 803.9336134347768
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 30
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 42
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 48
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 44
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 1
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
]
