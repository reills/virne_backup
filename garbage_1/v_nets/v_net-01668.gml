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
  id 1668
  arrival_time 37201.12915344412
  lifetime 1307.8222504715268
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 44
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 0
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 15
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 46
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 12
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 42
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
]
