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
  id 1623
  arrival_time 36217.61893552026
  lifetime 425.36986099566786
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 36
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 0
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 38
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 48
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 48
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
]
