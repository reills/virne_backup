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
  id 617
  arrival_time 12798.790563520442
  lifetime 2243.6417393688707
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 6
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 5
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 35
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 16
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 10
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 4
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 14
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 23
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
]
