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
  id 580
  arrival_time 10915.168162572194
  lifetime 6591.438360071253
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 29
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 22
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 18
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 10
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 27
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 25
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 11
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 41
    gpu 2
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 7
    rom 12
  ]
  node [
    id 9
    label "9"
    cpu 42
    gpu 43
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
]
