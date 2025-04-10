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
  id 582
  arrival_time 10943.76762426489
  lifetime 1473.626973775372
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 44
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 16
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 26
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 18
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 10
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 45
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 39
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 36
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 25
    rom 46
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 27
    rom 21
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 0
    rom 3
  ]
  node [
    id 11
    label "11"
    cpu 16
    gpu 39
    rom 32
  ]
  node [
    id 12
    label "12"
    cpu 2
    gpu 12
    rom 33
  ]
  node [
    id 13
    label "13"
    cpu 11
    gpu 30
    rom 23
  ]
  node [
    id 14
    label "14"
    cpu 29
    gpu 49
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 22
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 20
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
  edge [
    source 10
    target 11
    bw 13
  ]
  edge [
    source 11
    target 12
    bw 6
  ]
  edge [
    source 12
    target 13
    bw 29
  ]
  edge [
    source 13
    target 14
    bw 35
  ]
]
