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
  id 234
  arrival_time 4232.109478445
  lifetime 599.1581274727384
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 45
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 6
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 36
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 6
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 15
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 9
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 48
    rom 48
  ]
  node [
    id 7
    label "7"
    cpu 41
    gpu 29
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
]
