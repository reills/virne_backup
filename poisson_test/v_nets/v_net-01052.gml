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
  id 1052
  arrival_time 22151.379328055747
  lifetime 509.4697167854372
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 35
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 46
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 16
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 15
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 8
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 32
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 33
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 32
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 18
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
]
