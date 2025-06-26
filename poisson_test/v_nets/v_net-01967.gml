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
  id 1967
  arrival_time 42974.028582404346
  lifetime 437.6440629791873
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 30
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 50
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 18
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 14
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 34
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 46
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 43
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
]
