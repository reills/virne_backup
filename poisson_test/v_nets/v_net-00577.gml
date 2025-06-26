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
  id 577
  arrival_time 10775.250312458991
  lifetime 590.2724313407346
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 5
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 12
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 29
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
]
