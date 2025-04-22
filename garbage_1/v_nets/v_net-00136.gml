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
  id 136
  arrival_time 2364.4782690362463
  lifetime 1043.2977516843055
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 16
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 27
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 16
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 28
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 29
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 14
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 43
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 10
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 48
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
]
