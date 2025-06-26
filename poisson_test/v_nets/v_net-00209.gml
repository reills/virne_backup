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
  id 209
  arrival_time 3688.7463180734467
  lifetime 1337.3265882210117
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 30
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 34
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 23
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 10
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 34
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 12
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
]
