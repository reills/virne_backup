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
  id 1196
  arrival_time 24718.13969190221
  lifetime 1383.5112458019712
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 18
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 14
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 14
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 12
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 15
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 42
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 16
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 21
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 3
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 11
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
]
