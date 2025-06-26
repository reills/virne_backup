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
  id 193
  arrival_time 3508.4243985093135
  lifetime 1405.5434215731857
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 2
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 28
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 50
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 26
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 41
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 26
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 3
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 39
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 35
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 14
    gpu 19
    rom 3
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 22
    rom 23
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 35
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
]
