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
  id 587
  arrival_time 11696.386428884256
  lifetime 123.23444963264588
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 47
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 11
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 30
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 0
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
]
