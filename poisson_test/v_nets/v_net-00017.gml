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
  id 17
  arrival_time 505.8216417192012
  lifetime 4407.650468576172
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 41
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 39
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 2
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 47
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 16
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 17
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 8
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 3
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 48
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 27
    rom 42
  ]
  node [
    id 10
    label "10"
    cpu 2
    gpu 9
    rom 23
  ]
  node [
    id 11
    label "11"
    cpu 31
    gpu 6
    rom 28
  ]
  node [
    id 12
    label "12"
    cpu 23
    gpu 25
    rom 29
  ]
  node [
    id 13
    label "13"
    cpu 22
    gpu 36
    rom 43
  ]
  node [
    id 14
    label "14"
    cpu 27
    gpu 30
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 39
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 45
  ]
  edge [
    source 11
    target 12
    bw 2
  ]
  edge [
    source 12
    target 13
    bw 12
  ]
  edge [
    source 13
    target 14
    bw 0
  ]
]
