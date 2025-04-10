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
  id 92
  arrival_time 1890.5276396118663
  lifetime 1203.3227845915542
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 41
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 6
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 27
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
]
