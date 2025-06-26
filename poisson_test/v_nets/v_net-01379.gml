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
  id 1379
  arrival_time 29210.690353143083
  lifetime 2693.7031512335448
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 16
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 36
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 31
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 18
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 0
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 48
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 8
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 19
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 5
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 35
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 36
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 37
  ]
]
