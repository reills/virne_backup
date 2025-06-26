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
  id 634
  arrival_time 13263.540490392592
  lifetime 1226.352467683099
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 28
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 22
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 29
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 24
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 4
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 31
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 38
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 6
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 27
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 31
    rom 6
  ]
  node [
    id 10
    label "10"
    cpu 50
    gpu 3
    rom 41
  ]
  node [
    id 11
    label "11"
    cpu 2
    gpu 43
    rom 0
  ]
  node [
    id 12
    label "12"
    cpu 20
    gpu 33
    rom 0
  ]
  node [
    id 13
    label "13"
    cpu 27
    gpu 11
    rom 41
  ]
  node [
    id 14
    label "14"
    cpu 42
    gpu 22
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 35
  ]
  edge [
    source 7
    target 8
    bw 29
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 10
  ]
  edge [
    source 10
    target 11
    bw 28
  ]
  edge [
    source 11
    target 12
    bw 41
  ]
  edge [
    source 12
    target 13
    bw 6
  ]
  edge [
    source 13
    target 14
    bw 13
  ]
]
