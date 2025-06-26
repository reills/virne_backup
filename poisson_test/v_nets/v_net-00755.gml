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
  id 755
  arrival_time 15933.164955066175
  lifetime 1877.8111709708535
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 30
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 4
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 16
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 3
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 21
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 42
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 45
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 46
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 23
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 13
    gpu 34
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 6
    gpu 14
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
]
