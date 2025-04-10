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
  id 913
  arrival_time 19492.822298094907
  lifetime 693.4679802412343
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 4
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 29
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 13
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 22
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 45
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 42
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 19
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 20
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 9
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 6
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 41
    gpu 6
    rom 21
  ]
  node [
    id 11
    label "11"
    cpu 35
    gpu 12
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 15
  ]
  edge [
    source 10
    target 11
    bw 10
  ]
]
