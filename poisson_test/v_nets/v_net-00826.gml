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
  id 826
  arrival_time 17087.47350195506
  lifetime 1256.2300215430105
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 28
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 28
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 44
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 42
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 13
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 1
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 17
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
]
