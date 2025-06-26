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
  id 767
  arrival_time 16074.866926557448
  lifetime 3096.58538805985
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 13
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 25
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 42
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 25
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 10
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 3
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 43
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 29
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
]
