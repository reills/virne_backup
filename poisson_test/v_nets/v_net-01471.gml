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
  id 1471
  arrival_time 32033.103379250388
  lifetime 1544.7727524747784
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 11
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 32
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 30
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 2
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 25
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 11
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 10
    rom 32
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 13
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 20
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 16
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 5
    gpu 40
    rom 21
  ]
  node [
    id 11
    label "11"
    cpu 23
    gpu 26
    rom 4
  ]
  node [
    id 12
    label "12"
    cpu 15
    gpu 20
    rom 25
  ]
  node [
    id 13
    label "13"
    cpu 41
    gpu 0
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 41
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
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 10
  ]
  edge [
    source 9
    target 10
    bw 5
  ]
  edge [
    source 10
    target 11
    bw 18
  ]
  edge [
    source 11
    target 12
    bw 12
  ]
  edge [
    source 12
    target 13
    bw 40
  ]
]
