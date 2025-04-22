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
  id 81
  arrival_time 1629.4380924818795
  lifetime 1342.8258748493568
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 19
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 28
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 28
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
]
