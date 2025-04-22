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
  id 354
  arrival_time 6684.027456161474
  lifetime 787.6033612676525
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 6
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 13
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 12
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 31
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 22
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 17
    gpu 36
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 47
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 14
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
]
