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
  id 1826
  arrival_time 40393.77795197942
  lifetime 1039.7850842106054
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 40
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 5
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 12
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 1
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 45
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 32
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 12
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 49
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 0
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 7
    rom 22
  ]
  node [
    id 10
    label "10"
    cpu 50
    gpu 31
    rom 30
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 39
    rom 15
  ]
  node [
    id 12
    label "12"
    cpu 16
    gpu 28
    rom 1
  ]
  node [
    id 13
    label "13"
    cpu 47
    gpu 2
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 13
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
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 22
  ]
  edge [
    source 7
    target 8
    bw 38
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 47
  ]
  edge [
    source 11
    target 12
    bw 30
  ]
  edge [
    source 12
    target 13
    bw 8
  ]
]
