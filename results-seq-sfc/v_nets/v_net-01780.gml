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
  id 1780
  arrival_time 39577.6777316769
  lifetime 561.347986041962
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 28
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 13
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 9
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 20
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 28
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 36
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 5
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 5
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 11
    gpu 43
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 44
    gpu 5
    rom 6
  ]
  node [
    id 10
    label "10"
    cpu 29
    gpu 19
    rom 30
  ]
  node [
    id 11
    label "11"
    cpu 18
    gpu 39
    rom 42
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 4
    rom 39
  ]
  node [
    id 13
    label "13"
    cpu 39
    gpu 48
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 9
  ]
  edge [
    source 11
    target 12
    bw 2
  ]
  edge [
    source 12
    target 13
    bw 26
  ]
]
