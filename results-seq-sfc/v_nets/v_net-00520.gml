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
  id 520
  arrival_time 9868.558266591102
  lifetime 290.3804855229965
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 49
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 6
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 44
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 24
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 29
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 8
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 49
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 14
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
]
