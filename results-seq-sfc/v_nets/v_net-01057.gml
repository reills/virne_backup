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
  id 1057
  arrival_time 22318.59021612576
  lifetime 507.9720021615899
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 46
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 13
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 35
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 30
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 13
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 13
    rom 23
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 8
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 4
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 24
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
]
