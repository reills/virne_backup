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
  id 324
  arrival_time 6147.130932052402
  lifetime 1870.659103172281
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 29
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 34
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 25
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 13
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 33
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 10
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 38
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 50
    gpu 42
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 8
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 9
    rom 4
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 23
    rom 35
  ]
  node [
    id 11
    label "11"
    cpu 7
    gpu 25
    rom 37
  ]
  node [
    id 12
    label "12"
    cpu 13
    gpu 0
    rom 18
  ]
  node [
    id 13
    label "13"
    cpu 32
    gpu 39
    rom 4
  ]
  node [
    id 14
    label "14"
    cpu 19
    gpu 4
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
  edge [
    source 10
    target 11
    bw 15
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
  edge [
    source 12
    target 13
    bw 20
  ]
  edge [
    source 13
    target 14
    bw 46
  ]
]
