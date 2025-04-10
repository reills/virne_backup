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
  id 213
  arrival_time 3800.963961815264
  lifetime 175.24372077349236
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 29
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 43
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 26
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
]
