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
  id 1705
  arrival_time 37784.13002528254
  lifetime 454.1415820672946
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 3
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 21
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 16
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
]
