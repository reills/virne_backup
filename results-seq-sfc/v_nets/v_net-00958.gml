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
  id 958
  arrival_time 20381.858689406134
  lifetime 214.8348158130619
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 50
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 7
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 15
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 34
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 2
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 13
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 36
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 15
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 29
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
]
