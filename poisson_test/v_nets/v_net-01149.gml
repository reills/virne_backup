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
  id 1149
  arrival_time 23956.846311136527
  lifetime 2099.8754419673555
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 25
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 34
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 33
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 24
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 30
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 16
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 16
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 24
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 45
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
]
