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
  id 1686
  arrival_time 37590.16450561548
  lifetime 261.95651242076326
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 43
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 43
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 41
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 7
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 47
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 38
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 48
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 40
    rom 1
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 28
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 12
    rom 49
  ]
  node [
    id 10
    label "10"
    cpu 31
    gpu 36
    rom 15
  ]
  node [
    id 11
    label "11"
    cpu 29
    gpu 6
    rom 19
  ]
  node [
    id 12
    label "12"
    cpu 35
    gpu 4
    rom 12
  ]
  node [
    id 13
    label "13"
    cpu 20
    gpu 10
    rom 9
  ]
  node [
    id 14
    label "14"
    cpu 30
    gpu 6
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
  edge [
    source 9
    target 10
    bw 11
  ]
  edge [
    source 10
    target 11
    bw 24
  ]
  edge [
    source 11
    target 12
    bw 15
  ]
  edge [
    source 12
    target 13
    bw 41
  ]
  edge [
    source 13
    target 14
    bw 15
  ]
]
