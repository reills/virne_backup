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
  id 893
  arrival_time 18857.176950901532
  lifetime 681.7419148294913
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 47
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 46
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 42
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 1
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
]
