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
  id 1161
  arrival_time 24120.797473546998
  lifetime 489.9021866150494
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 46
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 21
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 46
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
]
