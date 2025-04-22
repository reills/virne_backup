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
  id 1390
  arrival_time 29330.092370102375
  lifetime 397.9347046618201
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 0
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 49
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 44
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 38
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 18
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 49
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 48
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 15
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
]
