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
  id 200
  arrival_time 3560.3218640213217
  lifetime 20.345097842282396
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 2
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 42
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 36
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
]
