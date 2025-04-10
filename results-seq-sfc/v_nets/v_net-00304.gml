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
  id 304
  arrival_time 5807.305308332527
  lifetime 379.72137777149754
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 23
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 39
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 29
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 44
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 28
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 16
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 12
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 34
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 34
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 3
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 9
    gpu 44
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
]
