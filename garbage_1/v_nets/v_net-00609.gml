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
  id 609
  arrival_time 12730.967132845524
  lifetime 36.21450156648631
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 24
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 2
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 18
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 28
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 8
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 23
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 7
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 34
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 19
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 13
    gpu 14
    rom 35
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 21
    rom 3
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 34
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 18
  ]
]
