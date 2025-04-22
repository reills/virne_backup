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
  id 146
  arrival_time 2580.4471776701853
  lifetime 723.750026525815
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 25
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 34
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 6
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 49
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 47
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 14
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 7
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 16
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 48
    rom 26
  ]
  node [
    id 9
    label "9"
    cpu 26
    gpu 14
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
]
