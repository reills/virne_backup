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
  id 1357
  arrival_time 28696.068868413666
  lifetime 370.24647121852735
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 37
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 19
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 0
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 8
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 50
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 38
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 35
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 26
    rom 21
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 43
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 9
    rom 28
  ]
  node [
    id 10
    label "10"
    cpu 41
    gpu 17
    rom 0
  ]
  node [
    id 11
    label "11"
    cpu 14
    gpu 42
    rom 29
  ]
  node [
    id 12
    label "12"
    cpu 5
    gpu 19
    rom 10
  ]
  node [
    id 13
    label "13"
    cpu 23
    gpu 20
    rom 40
  ]
  node [
    id 14
    label "14"
    cpu 49
    gpu 44
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 38
  ]
  edge [
    source 9
    target 10
    bw 10
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
  edge [
    source 11
    target 12
    bw 12
  ]
  edge [
    source 12
    target 13
    bw 10
  ]
  edge [
    source 13
    target 14
    bw 6
  ]
]
