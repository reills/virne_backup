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
  id 452
  arrival_time 8627.98017399582
  lifetime 585.363060016176
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 7
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 32
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 9
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 47
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 8
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 27
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 41
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 4
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 21
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 21
    gpu 41
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 39
    rom 32
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 37
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 39
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
  edge [
    source 9
    target 10
    bw 0
  ]
  edge [
    source 10
    target 11
    bw 23
  ]
]
