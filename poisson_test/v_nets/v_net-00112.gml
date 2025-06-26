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
  id 112
  arrival_time 2083.2694426320536
  lifetime 641.9981499195256
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 49
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 20
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 28
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 22
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 6
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 40
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 39
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 38
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 43
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
]
