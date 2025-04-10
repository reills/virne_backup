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
  id 788
  arrival_time 16240.444244619202
  lifetime 0.17814997833608917
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 43
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 2
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 13
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 32
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 17
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 30
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 48
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 50
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
]
