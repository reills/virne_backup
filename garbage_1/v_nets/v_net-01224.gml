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
  id 1224
  arrival_time 25394.116397223315
  lifetime 559.7850120716167
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 28
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 17
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 38
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 32
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 42
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 40
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 37
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 4
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 12
  ]
]
