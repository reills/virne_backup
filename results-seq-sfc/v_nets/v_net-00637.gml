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
  id 637
  arrival_time 13341.569305916562
  lifetime 154.20044891270535
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 18
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 33
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 37
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 39
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 8
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 13
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 21
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 36
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 24
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 35
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 5
    gpu 48
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 36
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
]
