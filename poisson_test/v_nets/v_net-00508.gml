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
  id 508
  arrival_time 9682.145323703082
  lifetime 149.5129603726809
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 45
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 47
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 35
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 30
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 3
    rom 47
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 36
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 8
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 49
    gpu 46
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
]
