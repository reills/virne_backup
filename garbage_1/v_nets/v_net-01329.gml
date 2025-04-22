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
  id 1329
  arrival_time 27932.751023639274
  lifetime 454.22590966719196
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 47
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 1
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 12
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 23
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 19
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 4
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 26
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
]
