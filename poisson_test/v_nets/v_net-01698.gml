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
  id 1698
  arrival_time 37688.84829723215
  lifetime 1115.8813646493636
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 34
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 38
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 27
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 47
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 22
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 26
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 35
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
]
