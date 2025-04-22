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
  id 1306
  arrival_time 27306.873427457853
  lifetime 1667.0830911455005
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 31
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 43
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 40
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 30
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 6
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 8
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 45
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 9
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 14
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 10
    gpu 0
    rom 18
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 39
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
]
