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
  id 941
  arrival_time 20108.694441310436
  lifetime 1202.2590753590569
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 13
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 46
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 43
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 50
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 14
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 17
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 33
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 29
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
]
