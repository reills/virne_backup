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
  id 45
  arrival_time 824.6684946329663
  lifetime 106.40211401159411
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 2
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 37
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 9
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 49
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 34
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
]
