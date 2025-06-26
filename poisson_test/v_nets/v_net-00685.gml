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
  id 685
  arrival_time 14443.243487573895
  lifetime 38.2442827031264
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 21
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 15
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 25
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
]
