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
  id 72
  arrival_time 1305.951837234649
  lifetime 461.63775928182156
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 1
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 32
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 32
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 20
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 30
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 9
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 28
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 49
    gpu 22
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 0
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 41
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 7
    gpu 21
    rom 28
  ]
  node [
    id 11
    label "11"
    cpu 33
    gpu 3
    rom 3
  ]
  node [
    id 12
    label "12"
    cpu 20
    gpu 21
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
  edge [
    source 9
    target 10
    bw 24
  ]
  edge [
    source 10
    target 11
    bw 6
  ]
  edge [
    source 11
    target 12
    bw 48
  ]
]
