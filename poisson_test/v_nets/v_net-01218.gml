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
  id 1218
  arrival_time 25283.062758813063
  lifetime 28.385822201161766
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 14
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 38
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 5
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 35
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 16
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 18
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 45
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 30
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 36
    gpu 3
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 44
    rom 28
  ]
  node [
    id 10
    label "10"
    cpu 23
    gpu 20
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
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
]
