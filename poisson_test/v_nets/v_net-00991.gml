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
  id 991
  arrival_time 21157.056490825784
  lifetime 3308.6828654754045
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 4
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 26
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 9
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 13
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 10
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 43
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 24
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 39
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 37
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 35
    rom 20
  ]
  node [
    id 10
    label "10"
    cpu 29
    gpu 31
    rom 1
  ]
  node [
    id 11
    label "11"
    cpu 18
    gpu 2
    rom 9
  ]
  node [
    id 12
    label "12"
    cpu 38
    gpu 23
    rom 17
  ]
  node [
    id 13
    label "13"
    cpu 8
    gpu 3
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 34
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
  edge [
    source 10
    target 11
    bw 2
  ]
  edge [
    source 11
    target 12
    bw 15
  ]
  edge [
    source 12
    target 13
    bw 9
  ]
]
