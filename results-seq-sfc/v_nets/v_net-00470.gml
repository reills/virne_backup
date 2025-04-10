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
  id 470
  arrival_time 8815.026257177258
  lifetime 2087.6892124682927
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 47
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 4
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 12
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 6
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 29
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 9
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 44
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 46
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
]
