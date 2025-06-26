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
  id 521
  arrival_time 9876.184532644276
  lifetime 1213.8108763352636
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 1
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 36
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 17
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 2
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 17
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 31
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 40
    rom 0
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 15
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 26
    rom 28
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 11
    rom 47
  ]
  node [
    id 10
    label "10"
    cpu 48
    gpu 41
    rom 24
  ]
  node [
    id 11
    label "11"
    cpu 23
    gpu 43
    rom 18
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 18
    rom 41
  ]
  node [
    id 13
    label "13"
    cpu 13
    gpu 16
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 34
  ]
  edge [
    source 9
    target 10
    bw 5
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
  edge [
    source 11
    target 12
    bw 28
  ]
  edge [
    source 12
    target 13
    bw 28
  ]
]
