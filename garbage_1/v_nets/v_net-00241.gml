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
  id 241
  arrival_time 4438.830485225125
  lifetime 2276.7488882202447
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 12
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 3
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 32
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 2
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 24
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 43
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 32
    rom 48
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 12
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 8
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 8
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 18
    gpu 15
    rom 4
  ]
  node [
    id 11
    label "11"
    cpu 36
    gpu 14
    rom 15
  ]
  node [
    id 12
    label "12"
    cpu 21
    gpu 10
    rom 34
  ]
  node [
    id 13
    label "13"
    cpu 5
    gpu 1
    rom 2
  ]
  node [
    id 14
    label "14"
    cpu 30
    gpu 9
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
  edge [
    source 9
    target 10
    bw 31
  ]
  edge [
    source 10
    target 11
    bw 9
  ]
  edge [
    source 11
    target 12
    bw 13
  ]
  edge [
    source 12
    target 13
    bw 43
  ]
  edge [
    source 13
    target 14
    bw 22
  ]
]
