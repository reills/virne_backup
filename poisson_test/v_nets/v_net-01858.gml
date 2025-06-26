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
  id 1858
  arrival_time 40917.04601709249
  lifetime 580.9197535840065
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 44
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 17
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 7
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
]
