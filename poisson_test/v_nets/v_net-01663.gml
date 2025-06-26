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
  id 1663
  arrival_time 37168.600869593596
  lifetime 483.42087321471183
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 21
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 21
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 14
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 38
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 7
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 42
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
]
