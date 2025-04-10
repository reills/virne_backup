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
  id 1557
  arrival_time 34911.09008860274
  lifetime 767.3261905065295
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 30
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 38
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 34
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 13
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 31
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 7
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 37
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
]
