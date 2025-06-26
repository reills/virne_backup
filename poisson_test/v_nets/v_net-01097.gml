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
  id 1097
  arrival_time 22860.74708646696
  lifetime 259.94677897261226
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 8
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 22
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 9
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 38
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 39
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 43
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 16
    gpu 34
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
]
