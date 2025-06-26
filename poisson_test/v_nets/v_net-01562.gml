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
  id 1562
  arrival_time 34988.5780099649
  lifetime 265.1475701080515
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 19
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 20
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 50
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 25
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
]
