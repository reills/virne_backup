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
  id 1193
  arrival_time 24710.46099006487
  lifetime 422.8265278636215
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 22
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 1
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 24
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
]
