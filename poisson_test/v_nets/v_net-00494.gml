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
  id 494
  arrival_time 9267.36912884654
  lifetime 58.74861808087498
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 2
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 16
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
]
