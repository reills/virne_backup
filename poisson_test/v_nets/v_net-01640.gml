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
  id 1640
  arrival_time 36666.134041542064
  lifetime 720.5980242017654
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 14
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 48
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 22
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 22
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 31
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 22
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 38
    rom 0
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 43
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 44
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 6
    rom 32
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 21
    rom 42
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 19
    rom 49
  ]
  node [
    id 12
    label "12"
    cpu 26
    gpu 48
    rom 14
  ]
  node [
    id 13
    label "13"
    cpu 32
    gpu 15
    rom 22
  ]
  node [
    id 14
    label "14"
    cpu 49
    gpu 47
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
  edge [
    source 10
    target 11
    bw 40
  ]
  edge [
    source 11
    target 12
    bw 5
  ]
  edge [
    source 12
    target 13
    bw 3
  ]
  edge [
    source 13
    target 14
    bw 22
  ]
]
