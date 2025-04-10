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
  id 1108
  arrival_time 23143.81293945215
  lifetime 243.07793980354836
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 38
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 26
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 2
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 28
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 8
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 17
    gpu 35
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 3
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
]
