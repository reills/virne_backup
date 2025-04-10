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
  id 645
  arrival_time 13390.601012718897
  lifetime 21.031389606589084
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 7
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 37
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 18
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 8
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 8
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 20
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 4
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 47
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 39
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 42
    rom 49
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 19
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 35
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 6
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
]
