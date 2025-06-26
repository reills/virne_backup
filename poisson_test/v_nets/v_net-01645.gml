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
  id 1645
  arrival_time 36738.25244650447
  lifetime 1226.8149438928783
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 41
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 26
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 2
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 5
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 23
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 38
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 3
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 23
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 50
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 3
    rom 34
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 21
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 15
    rom 19
  ]
  node [
    id 12
    label "12"
    cpu 11
    gpu 15
    rom 40
  ]
  node [
    id 13
    label "13"
    cpu 25
    gpu 48
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 3
  ]
  edge [
    source 12
    target 13
    bw 41
  ]
]
