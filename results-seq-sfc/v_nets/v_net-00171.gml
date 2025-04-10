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
  id 171
  arrival_time 3208.953368385806
  lifetime 582.6571898359522
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 48
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 46
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
]
