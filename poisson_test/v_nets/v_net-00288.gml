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
  id 288
  arrival_time 5607.951748875922
  lifetime 1693.2152217879845
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 42
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 5
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 22
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 43
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 4
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 36
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 46
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 36
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 21
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 18
    rom 21
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 14
    rom 30
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 13
    rom 50
  ]
  node [
    id 12
    label "12"
    cpu 44
    gpu 15
    rom 17
  ]
  node [
    id 13
    label "13"
    cpu 40
    gpu 24
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 47
  ]
  edge [
    source 10
    target 11
    bw 45
  ]
  edge [
    source 11
    target 12
    bw 16
  ]
  edge [
    source 12
    target 13
    bw 42
  ]
]
