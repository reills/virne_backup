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
  id 15
  arrival_time 466.88398213023197
  lifetime 888.0469217681574
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 4
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 38
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 1
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 21
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
]
