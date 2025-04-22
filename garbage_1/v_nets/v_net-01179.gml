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
  id 1179
  arrival_time 24389.819340549446
  lifetime 979.1277476770719
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 25
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 27
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 31
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 41
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 18
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 41
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 20
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 30
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 0
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 34
  ]
]
