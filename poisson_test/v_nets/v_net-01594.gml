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
  id 1594
  arrival_time 35841.965172820324
  lifetime 1019.1084222710481
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 31
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 43
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 13
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 47
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 2
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 32
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 17
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 45
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
]
