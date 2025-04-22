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
  id 116
  arrival_time 2144.294632756721
  lifetime 1175.745598083414
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 39
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 11
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 42
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 50
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 11
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
]
