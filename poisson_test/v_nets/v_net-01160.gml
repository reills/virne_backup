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
  id 1160
  arrival_time 24119.702407076024
  lifetime 417.2854166106548
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 13
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 7
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 37
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 9
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 7
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 22
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 48
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 24
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 15
    rom 47
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 18
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
]
