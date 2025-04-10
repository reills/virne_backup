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
  id 922
  arrival_time 19801.016311603165
  lifetime 398.0017863499325
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 9
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 9
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 7
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 50
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 34
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 9
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 30
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 19
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
]
