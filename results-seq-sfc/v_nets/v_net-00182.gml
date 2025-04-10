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
  id 182
  arrival_time 3325.7208571190713
  lifetime 616.2582694810577
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 47
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 0
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 16
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 29
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 29
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 18
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 40
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 14
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
]
