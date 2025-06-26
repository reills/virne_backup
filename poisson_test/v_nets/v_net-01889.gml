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
  id 1889
  arrival_time 41565.26215256681
  lifetime 561.6862280034519
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 23
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 11
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 49
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 36
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 16
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 37
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 49
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 43
    rom 3
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 1
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
]
