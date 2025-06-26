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
  id 1704
  arrival_time 37753.96911337285
  lifetime 1189.5043084768556
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 28
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 1
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 4
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 4
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 40
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 28
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 39
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 21
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 14
    rom 8
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 1
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 13
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 8
    gpu 30
    rom 26
  ]
  node [
    id 12
    label "12"
    cpu 24
    gpu 9
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
  edge [
    source 10
    target 11
    bw 1
  ]
  edge [
    source 11
    target 12
    bw 49
  ]
]
