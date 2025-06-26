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
  id 106
  arrival_time 2015.954531928015
  lifetime 2032.0612398715018
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 46
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 50
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 34
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 22
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
]
