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
  id 691
  arrival_time 14588.839416174655
  lifetime 1182.1038689998181
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 45
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 30
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 47
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 35
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 37
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 34
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 7
    rom 32
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 26
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 28
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 32
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
]
