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
  id 633
  arrival_time 13261.933112596107
  lifetime 4730.474734192236
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 18
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 17
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 29
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 32
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 36
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 41
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 0
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 42
    gpu 28
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 31
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 38
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
]
