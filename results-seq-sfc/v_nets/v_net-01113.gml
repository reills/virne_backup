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
  id 1113
  arrival_time 23194.94437983117
  lifetime 556.7115811676624
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 41
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 27
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 10
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 40
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 21
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 7
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 15
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
]
