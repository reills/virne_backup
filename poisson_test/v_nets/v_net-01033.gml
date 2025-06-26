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
  id 1033
  arrival_time 21880.685868589542
  lifetime 574.8655621178541
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 31
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 20
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 43
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 4
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 24
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 0
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 21
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 11
    gpu 49
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 18
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 2
    gpu 49
    rom 27
  ]
  node [
    id 10
    label "10"
    cpu 48
    gpu 0
    rom 5
  ]
  node [
    id 11
    label "11"
    cpu 1
    gpu 30
    rom 1
  ]
  node [
    id 12
    label "12"
    cpu 17
    gpu 0
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 36
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 41
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 6
  ]
]
