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
  id 1124
  arrival_time 23348.73003053127
  lifetime 420.63217822386025
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 7
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 26
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 42
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 50
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 1
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 42
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
]
