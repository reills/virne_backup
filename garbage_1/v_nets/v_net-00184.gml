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
  id 184
  arrival_time 3389.7300384408472
  lifetime 267.29665286657877
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 40
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 25
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 7
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 23
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 39
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 18
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
]
