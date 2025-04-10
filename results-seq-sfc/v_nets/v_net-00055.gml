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
  id 55
  arrival_time 1145.070266908237
  lifetime 1382.7769565241626
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 20
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 14
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 44
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 28
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 32
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 17
    gpu 34
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 24
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 28
    rom 17
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 14
    rom 16
  ]
  node [
    id 9
    label "9"
    cpu 2
    gpu 48
    rom 25
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 24
    rom 23
  ]
  node [
    id 11
    label "11"
    cpu 4
    gpu 21
    rom 49
  ]
  node [
    id 12
    label "12"
    cpu 12
    gpu 34
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 25
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
  edge [
    source 9
    target 10
    bw 35
  ]
  edge [
    source 10
    target 11
    bw 23
  ]
  edge [
    source 11
    target 12
    bw 7
  ]
]
