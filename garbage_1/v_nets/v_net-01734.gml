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
  id 1734
  arrival_time 38763.179463590386
  lifetime 757.6265786176738
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 44
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 45
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 38
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 6
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 3
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
]
