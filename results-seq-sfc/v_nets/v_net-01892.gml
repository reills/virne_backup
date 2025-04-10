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
  id 1892
  arrival_time 41779.61718336937
  lifetime 611.865667196418
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 42
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 2
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 37
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
]
