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
  id 372
  arrival_time 7026.809667616508
  lifetime 1043.1919725014075
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 33
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 36
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 26
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 48
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
]
