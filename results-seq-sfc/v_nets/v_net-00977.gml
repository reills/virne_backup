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
  id 977
  arrival_time 20866.432197616363
  lifetime 599.3237875958027
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 35
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 42
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 25
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 23
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 28
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 4
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 45
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
]
