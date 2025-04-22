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
  id 1577
  arrival_time 35499.080401580446
  lifetime 329.5658166068314
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 26
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 44
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 19
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 8
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 19
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 24
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 5
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 20
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 35
    gpu 46
    rom 45
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 22
    rom 38
  ]
  node [
    id 10
    label "10"
    cpu 18
    gpu 26
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 10
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
    bw 42
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
  edge [
    source 9
    target 10
    bw 11
  ]
]
