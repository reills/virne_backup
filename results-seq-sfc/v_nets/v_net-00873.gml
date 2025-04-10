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
  id 873
  arrival_time 18141.46156379637
  lifetime 415.8206059385339
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 40
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 39
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 0
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
]
