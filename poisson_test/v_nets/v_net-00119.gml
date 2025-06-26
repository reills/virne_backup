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
  id 119
  arrival_time 2150.2387339133224
  lifetime 4420.686491385082
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 36
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 30
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 48
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 45
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 28
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 42
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 1
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 47
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 43
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 4
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 42
  ]
  edge [
    source 8
    target 9
    bw 34
  ]
]
