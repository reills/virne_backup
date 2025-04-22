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
  id 1139
  arrival_time 23850.112385501692
  lifetime 1015.5259494873247
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 15
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 43
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 43
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 35
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 46
    rom 47
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 39
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 46
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 41
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 19
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 15
    rom 16
  ]
  node [
    id 10
    label "10"
    cpu 5
    gpu 0
    rom 2
  ]
  node [
    id 11
    label "11"
    cpu 27
    gpu 21
    rom 23
  ]
  node [
    id 12
    label "12"
    cpu 25
    gpu 48
    rom 36
  ]
  node [
    id 13
    label "13"
    cpu 40
    gpu 32
    rom 42
  ]
  node [
    id 14
    label "14"
    cpu 22
    gpu 22
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 18
  ]
  edge [
    source 10
    target 11
    bw 7
  ]
  edge [
    source 11
    target 12
    bw 6
  ]
  edge [
    source 12
    target 13
    bw 30
  ]
  edge [
    source 13
    target 14
    bw 35
  ]
]
