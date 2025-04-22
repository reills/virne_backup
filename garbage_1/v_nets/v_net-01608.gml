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
  id 1608
  arrival_time 36011.219774700345
  lifetime 682.6812239700612
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 1
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 20
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 11
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 5
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 46
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 44
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 49
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
]
