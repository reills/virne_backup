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
  id 1059
  arrival_time 22338.843259110217
  lifetime 1437.7428570572822
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 7
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 35
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 31
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 7
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 25
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 47
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 36
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 1
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 48
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 38
  ]
]
