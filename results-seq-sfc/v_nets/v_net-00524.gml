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
  id 524
  arrival_time 10050.203135421945
  lifetime 3224.0490746654013
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 26
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 30
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 39
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 19
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 6
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 16
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 16
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 26
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
]
