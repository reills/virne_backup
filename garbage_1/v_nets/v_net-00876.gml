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
  id 876
  arrival_time 18287.71961365482
  lifetime 862.2507954467488
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 37
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 24
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 3
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 3
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 4
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 21
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 47
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 49
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 16
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 31
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
]
