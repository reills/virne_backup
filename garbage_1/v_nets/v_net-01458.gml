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
  id 1458
  arrival_time 30621.581580022983
  lifetime 3342.983207726329
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 9
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 7
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 4
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 16
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 34
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 22
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 15
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 16
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 7
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 48
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 24
    rom 3
  ]
  node [
    id 11
    label "11"
    cpu 40
    gpu 49
    rom 22
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 36
    rom 29
  ]
  node [
    id 13
    label "13"
    cpu 9
    gpu 16
    rom 6
  ]
  node [
    id 14
    label "14"
    cpu 47
    gpu 18
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
  edge [
    source 10
    target 11
    bw 49
  ]
  edge [
    source 11
    target 12
    bw 24
  ]
  edge [
    source 12
    target 13
    bw 18
  ]
  edge [
    source 13
    target 14
    bw 3
  ]
]
