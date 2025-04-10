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
  id 322
  arrival_time 6128.555719147546
  lifetime 13.15053738704436
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 12
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 32
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 28
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 44
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 4
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 10
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 16
    gpu 23
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
]
