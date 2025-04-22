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
  id 643
  arrival_time 13384.552956463944
  lifetime 416.6783545732277
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 33
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 44
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 50
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 23
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 30
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 31
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 13
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 36
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 7
    rom 31
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 40
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 32
    gpu 12
    rom 42
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 6
    rom 35
  ]
  node [
    id 12
    label "12"
    cpu 12
    gpu 33
    rom 49
  ]
  node [
    id 13
    label "13"
    cpu 13
    gpu 36
    rom 14
  ]
  node [
    id 14
    label "14"
    cpu 41
    gpu 25
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 38
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
  edge [
    source 10
    target 11
    bw 13
  ]
  edge [
    source 11
    target 12
    bw 43
  ]
  edge [
    source 12
    target 13
    bw 45
  ]
  edge [
    source 13
    target 14
    bw 24
  ]
]
