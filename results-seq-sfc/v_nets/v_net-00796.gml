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
  id 796
  arrival_time 16629.265029831204
  lifetime 910.550432980935
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 29
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 37
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 39
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 28
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
]
