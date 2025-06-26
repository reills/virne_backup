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
  id 1585
  arrival_time 35760.26056376701
  lifetime 274.7578872722332
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 48
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 12
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 47
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 10
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 38
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 35
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 15
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
]
