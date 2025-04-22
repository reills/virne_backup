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
  id 990
  arrival_time 21146.65383142315
  lifetime 287.7756469471115
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 7
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 39
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 36
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 7
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 0
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 13
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 0
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 33
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 1
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 28
  ]
]
