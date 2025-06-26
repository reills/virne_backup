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
  id 1067
  arrival_time 22415.18642578424
  lifetime 114.94678928430035
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 27
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 30
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 5
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 8
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 2
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 3
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 39
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 19
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 19
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 36
    rom 18
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 16
    rom 16
  ]
  node [
    id 11
    label "11"
    cpu 11
    gpu 1
    rom 22
  ]
  node [
    id 12
    label "12"
    cpu 15
    gpu 16
    rom 32
  ]
  node [
    id 13
    label "13"
    cpu 15
    gpu 39
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 22
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 19
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
  edge [
    source 12
    target 13
    bw 22
  ]
]
