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
  id 891
  arrival_time 18834.534486708
  lifetime 329.8227369552977
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 13
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 36
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 41
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 11
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 18
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 40
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 25
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 14
    rom 2
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 50
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 43
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 11
    rom 5
  ]
  node [
    id 11
    label "11"
    cpu 15
    gpu 38
    rom 30
  ]
  node [
    id 12
    label "12"
    cpu 7
    gpu 19
    rom 11
  ]
  node [
    id 13
    label "13"
    cpu 44
    gpu 48
    rom 8
  ]
  node [
    id 14
    label "14"
    cpu 8
    gpu 7
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 30
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
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 25
  ]
  edge [
    source 9
    target 10
    bw 38
  ]
  edge [
    source 10
    target 11
    bw 34
  ]
  edge [
    source 11
    target 12
    bw 16
  ]
  edge [
    source 12
    target 13
    bw 43
  ]
  edge [
    source 13
    target 14
    bw 49
  ]
]
