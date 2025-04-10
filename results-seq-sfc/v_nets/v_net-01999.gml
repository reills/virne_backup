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
  id 1999
  arrival_time 43662.63156826825
  lifetime 1674.7374591745536
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 23
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 27
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 20
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
]
