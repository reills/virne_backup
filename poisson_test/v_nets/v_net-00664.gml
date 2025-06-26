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
  id 664
  arrival_time 14175.661151184404
  lifetime 1368.4646734013822
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 7
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 25
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 8
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
]
