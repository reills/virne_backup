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
  id 30
  arrival_time 588.316099032715
  lifetime 929.4920736260683
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 11
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 18
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 10
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
]
