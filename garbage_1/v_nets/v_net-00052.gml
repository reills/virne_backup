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
  id 52
  arrival_time 1073.6287171061194
  lifetime 179.59393042453019
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 6
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 22
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 18
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 50
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 21
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 9
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 29
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 40
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 19
    rom 23
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 39
    rom 41
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 25
    rom 6
  ]
  node [
    id 11
    label "11"
    cpu 27
    gpu 39
    rom 36
  ]
  node [
    id 12
    label "12"
    cpu 4
    gpu 40
    rom 19
  ]
  node [
    id 13
    label "13"
    cpu 47
    gpu 36
    rom 1
  ]
  node [
    id 14
    label "14"
    cpu 45
    gpu 39
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 41
  ]
  edge [
    source 10
    target 11
    bw 6
  ]
  edge [
    source 11
    target 12
    bw 29
  ]
  edge [
    source 12
    target 13
    bw 48
  ]
  edge [
    source 13
    target 14
    bw 4
  ]
]
