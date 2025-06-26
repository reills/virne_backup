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
  id 1081
  arrival_time 22623.92587967202
  lifetime 570.2320208878199
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 40
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 36
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 15
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 29
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 29
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 8
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 38
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 12
    rom 21
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 20
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
]
