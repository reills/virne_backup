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
  id 1374
  arrival_time 29178.524956737445
  lifetime 1446.2968358367627
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 2
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 35
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 8
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 24
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 18
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 34
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 29
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
]
