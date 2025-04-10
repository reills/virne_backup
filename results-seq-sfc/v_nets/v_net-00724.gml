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
  id 724
  arrival_time 15282.62117973292
  lifetime 1375.7488223940366
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 47
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 17
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 31
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 27
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 48
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 15
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 26
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 46
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 26
    rom 45
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 7
    rom 0
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 45
    rom 26
  ]
  node [
    id 11
    label "11"
    cpu 32
    gpu 34
    rom 45
  ]
  node [
    id 12
    label "12"
    cpu 12
    gpu 10
    rom 14
  ]
  node [
    id 13
    label "13"
    cpu 48
    gpu 43
    rom 42
  ]
  node [
    id 14
    label "14"
    cpu 36
    gpu 30
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 26
  ]
  edge [
    source 10
    target 11
    bw 45
  ]
  edge [
    source 11
    target 12
    bw 28
  ]
  edge [
    source 12
    target 13
    bw 20
  ]
  edge [
    source 13
    target 14
    bw 12
  ]
]
