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
  id 130
  arrival_time 2315.0333108711375
  lifetime 154.90718178961637
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 29
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 12
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 25
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 40
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 34
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 7
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 42
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
]
