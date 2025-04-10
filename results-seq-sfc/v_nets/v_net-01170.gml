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
  id 1170
  arrival_time 24213.954687797912
  lifetime 2550.335987554652
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 1
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 48
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 36
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 45
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 27
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 45
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 48
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 25
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 3
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 32
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
]
