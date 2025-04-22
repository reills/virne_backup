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
  id 402
  arrival_time 7912.273236167894
  lifetime 237.10576258959446
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 26
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 28
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 43
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 39
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 28
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 8
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 30
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 1
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 42
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 30
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 30
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
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
]
