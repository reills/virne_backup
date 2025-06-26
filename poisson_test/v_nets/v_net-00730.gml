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
  id 730
  arrival_time 15340.488002193226
  lifetime 400.5849428470565
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 13
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 13
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 2
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 23
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 10
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 12
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 47
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
]
