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
  id 1692
  arrival_time 37633.921666425704
  lifetime 428.742654890533
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 45
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 39
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 47
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 47
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 44
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 26
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 21
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
]
