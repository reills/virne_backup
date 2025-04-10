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
  id 585
  arrival_time 10988.77316984882
  lifetime 361.59210461343105
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 28
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 35
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 7
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 37
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 8
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 38
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 11
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 24
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 43
    gpu 33
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 42
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
]
