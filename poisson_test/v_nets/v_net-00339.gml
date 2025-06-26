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
  id 339
  arrival_time 6387.672396996416
  lifetime 746.0118986051557
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 21
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 31
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 4
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 1
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 27
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 10
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 43
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 43
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 23
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
]
