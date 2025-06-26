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
  id 1845
  arrival_time 40707.04878221133
  lifetime 166.23766445124332
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 20
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 19
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 48
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 13
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 9
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 16
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 49
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
]
