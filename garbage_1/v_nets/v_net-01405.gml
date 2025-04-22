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
  id 1405
  arrival_time 29446.41968016385
  lifetime 146.15749065488734
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 47
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 39
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 39
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 16
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 32
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 1
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 18
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 15
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 11
    gpu 28
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 2
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
]
