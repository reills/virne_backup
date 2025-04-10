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
  id 1237
  arrival_time 25542.735829855974
  lifetime 921.4781032125907
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 46
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 46
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 15
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 6
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
]
