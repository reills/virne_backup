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
  id 1375
  arrival_time 29187.70378444915
  lifetime 372.2885475347714
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 47
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 31
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 30
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 27
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 5
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 47
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 0
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 42
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 19
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 40
    gpu 38
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 8
  ]
  edge [
    source 8
    target 9
    bw 20
  ]
]
