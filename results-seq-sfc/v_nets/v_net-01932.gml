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
  id 1932
  arrival_time 42621.32229112098
  lifetime 21.13241245087676
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 34
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 41
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 8
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
]
