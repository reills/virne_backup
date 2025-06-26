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
  id 1016
  arrival_time 21640.99989981675
  lifetime 500.4001999900598
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 47
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 32
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 26
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 46
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 48
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
]
