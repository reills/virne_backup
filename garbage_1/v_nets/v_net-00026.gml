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
  id 26
  arrival_time 567.2028764669619
  lifetime 711.3142813997357
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 16
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 49
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 9
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 0
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 22
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 43
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 26
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 50
    gpu 48
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
]
