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
  id 1243
  arrival_time 25693.240089829527
  lifetime 2894.115543115996
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 15
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 33
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 14
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 18
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
]
