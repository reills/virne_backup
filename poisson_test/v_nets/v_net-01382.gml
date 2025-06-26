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
  id 1382
  arrival_time 29230.505261826405
  lifetime 528.2596087319171
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 32
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 25
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 3
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 50
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 35
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 44
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 16
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 30
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 19
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 40
    gpu 42
    rom 0
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 12
    rom 21
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 12
    rom 1
  ]
  node [
    id 12
    label "12"
    cpu 8
    gpu 39
    rom 19
  ]
  node [
    id 13
    label "13"
    cpu 30
    gpu 23
    rom 10
  ]
  node [
    id 14
    label "14"
    cpu 47
    gpu 6
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 8
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
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 28
  ]
  edge [
    source 11
    target 12
    bw 26
  ]
  edge [
    source 12
    target 13
    bw 13
  ]
  edge [
    source 13
    target 14
    bw 2
  ]
]
