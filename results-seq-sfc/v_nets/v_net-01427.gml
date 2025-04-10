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
  id 1427
  arrival_time 29944.81145226323
  lifetime 823.2702849198712
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 5
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 24
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 35
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 1
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
]
