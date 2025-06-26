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
  id 150
  arrival_time 2683.743383296633
  lifetime 514.4256478370401
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 30
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 13
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 23
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 20
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 45
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 42
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 7
    rom 48
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 38
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 12
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
]
