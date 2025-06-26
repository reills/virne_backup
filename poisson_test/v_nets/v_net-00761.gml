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
  id 761
  arrival_time 16026.1428046137
  lifetime 2530.7693663178216
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 24
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 37
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
]
