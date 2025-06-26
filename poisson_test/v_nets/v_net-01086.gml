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
  id 1086
  arrival_time 22641.66016255552
  lifetime 770.9027952502018
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 31
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 46
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 14
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 13
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 3
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 38
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 7
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
]
