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
  id 1225
  arrival_time 25397.513006332003
  lifetime 1187.746375610854
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 11
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 36
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 16
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 50
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 7
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 30
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 43
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
]
