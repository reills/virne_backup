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
  id 423
  arrival_time 8297.753729510952
  lifetime 1461.8008473049135
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 25
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 45
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 1
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 32
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 11
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 47
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
]
