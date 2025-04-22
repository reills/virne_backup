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
  id 358
  arrival_time 6833.556442714058
  lifetime 250.72249712726713
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 16
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 7
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 12
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 9
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 18
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 47
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 29
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 36
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
]
