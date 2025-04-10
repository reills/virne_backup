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
  id 556
  arrival_time 10509.326705697851
  lifetime 1454.1241488686985
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 4
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 8
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 30
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 13
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 5
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 5
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 4
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 29
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 40
    rom 44
  ]
  node [
    id 9
    label "9"
    cpu 1
    gpu 38
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 19
    gpu 21
    rom 11
  ]
  node [
    id 11
    label "11"
    cpu 5
    gpu 49
    rom 47
  ]
  node [
    id 12
    label "12"
    cpu 40
    gpu 44
    rom 47
  ]
  node [
    id 13
    label "13"
    cpu 19
    gpu 44
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 16
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 13
  ]
  edge [
    source 12
    target 13
    bw 7
  ]
]
