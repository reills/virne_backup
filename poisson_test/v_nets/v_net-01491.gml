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
  id 1491
  arrival_time 32955.90845755903
  lifetime 349.70815405860577
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 4
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 21
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 31
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 24
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 12
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 25
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 9
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 30
    rom 50
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 22
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 40
    gpu 34
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 22
    gpu 48
    rom 43
  ]
  node [
    id 11
    label "11"
    cpu 32
    gpu 12
    rom 8
  ]
  node [
    id 12
    label "12"
    cpu 31
    gpu 20
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
  edge [
    source 9
    target 10
    bw 47
  ]
  edge [
    source 10
    target 11
    bw 39
  ]
  edge [
    source 11
    target 12
    bw 33
  ]
]
