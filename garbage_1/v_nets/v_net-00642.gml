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
  id 642
  arrival_time 13380.344299963417
  lifetime 216.09289838443394
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 41
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 20
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 20
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 32
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 36
    gpu 13
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 17
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 5
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 11
    gpu 11
    rom 50
  ]
  node [
    id 8
    label "8"
    cpu 33
    gpu 5
    rom 37
  ]
  node [
    id 9
    label "9"
    cpu 1
    gpu 38
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 36
    gpu 47
    rom 5
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 43
    rom 37
  ]
  node [
    id 12
    label "12"
    cpu 25
    gpu 14
    rom 19
  ]
  node [
    id 13
    label "13"
    cpu 25
    gpu 6
    rom 4
  ]
  node [
    id 14
    label "14"
    cpu 5
    gpu 17
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 25
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 16
  ]
  edge [
    source 11
    target 12
    bw 18
  ]
  edge [
    source 12
    target 13
    bw 35
  ]
  edge [
    source 13
    target 14
    bw 13
  ]
]
