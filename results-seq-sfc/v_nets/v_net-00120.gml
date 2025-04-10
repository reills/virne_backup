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
  id 120
  arrival_time 2154.878236143379
  lifetime 98.61981807193473
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 34
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 48
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 7
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 45
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 31
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 48
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 22
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 32
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 24
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 26
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 28
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 40
    rom 34
  ]
  node [
    id 12
    label "12"
    cpu 27
    gpu 6
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 31
  ]
  edge [
    source 10
    target 11
    bw 16
  ]
  edge [
    source 11
    target 12
    bw 3
  ]
]
