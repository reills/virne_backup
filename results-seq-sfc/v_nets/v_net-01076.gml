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
  id 1076
  arrival_time 22487.50454425327
  lifetime 2121.5184931808853
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 42
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 8
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 6
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 24
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 28
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 50
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 28
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 5
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 43
    gpu 15
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 14
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 29
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
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 34
  ]
]
