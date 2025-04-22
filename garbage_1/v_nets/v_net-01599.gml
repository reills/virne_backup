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
  id 1599
  arrival_time 35870.59391748184
  lifetime 1395.6900237110497
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 12
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 36
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 37
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 4
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
]
