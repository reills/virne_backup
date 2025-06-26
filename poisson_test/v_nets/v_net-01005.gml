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
  id 1005
  arrival_time 21522.031077614374
  lifetime 1432.0584288462178
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 1
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 21
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 38
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 47
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
]
