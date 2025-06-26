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
  id 1600
  arrival_time 35876.312461242764
  lifetime 407.9678181068563
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 18
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 1
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 5
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 49
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 30
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 20
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 38
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 35
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 29
    rom 34
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
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
]
