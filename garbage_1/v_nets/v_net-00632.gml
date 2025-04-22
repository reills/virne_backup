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
  id 632
  arrival_time 13253.19249860588
  lifetime 739.5682274533285
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 40
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 1
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 28
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 5
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 37
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 23
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 26
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 28
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 20
    gpu 11
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 10
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 9
    gpu 49
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 8
    gpu 46
    rom 35
  ]
  node [
    id 12
    label "12"
    cpu 15
    gpu 27
    rom 12
  ]
  node [
    id 13
    label "13"
    cpu 17
    gpu 33
    rom 18
  ]
  node [
    id 14
    label "14"
    cpu 12
    gpu 4
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
  edge [
    source 8
    target 9
    bw 34
  ]
  edge [
    source 9
    target 10
    bw 17
  ]
  edge [
    source 10
    target 11
    bw 27
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
  edge [
    source 12
    target 13
    bw 4
  ]
  edge [
    source 13
    target 14
    bw 3
  ]
]
