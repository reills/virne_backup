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
  id 1584
  arrival_time 35759.451934271194
  lifetime 1156.7019946304927
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 39
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 2
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 34
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 1
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 7
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 26
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 25
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 24
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 0
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
]
