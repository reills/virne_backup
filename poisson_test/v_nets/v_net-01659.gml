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
  id 1659
  arrival_time 37058.252914795106
  lifetime 1262.1776954747522
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 44
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 50
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 1
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 5
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
]
