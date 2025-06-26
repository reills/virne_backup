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
  id 481
  arrival_time 8902.709168087446
  lifetime 2303.5335653386037
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 34
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 18
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 35
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 48
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 9
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 8
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 20
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
]
