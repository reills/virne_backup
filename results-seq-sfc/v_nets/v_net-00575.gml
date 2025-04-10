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
  id 575
  arrival_time 10766.086394145743
  lifetime 3209.5632087529025
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 8
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 47
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 21
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 26
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 0
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 0
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 24
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 42
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 40
    rom 37
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 2
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 9
    gpu 35
    rom 11
  ]
  node [
    id 11
    label "11"
    cpu 17
    gpu 1
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 34
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 23
  ]
]
