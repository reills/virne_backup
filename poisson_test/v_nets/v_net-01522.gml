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
  id 1522
  arrival_time 33744.52584100051
  lifetime 833.7278297901694
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 29
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 42
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 23
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 5
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 15
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 7
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 11
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 5
    rom 1
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 11
    rom 7
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 2
    rom 45
  ]
  node [
    id 10
    label "10"
    cpu 16
    gpu 18
    rom 32
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 34
    rom 15
  ]
  node [
    id 12
    label "12"
    cpu 36
    gpu 3
    rom 33
  ]
  node [
    id 13
    label "13"
    cpu 49
    gpu 47
    rom 43
  ]
  node [
    id 14
    label "14"
    cpu 43
    gpu 5
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 22
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 42
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
  edge [
    source 11
    target 12
    bw 49
  ]
  edge [
    source 12
    target 13
    bw 1
  ]
  edge [
    source 13
    target 14
    bw 47
  ]
]
