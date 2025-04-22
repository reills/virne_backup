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
  id 1460
  arrival_time 30627.05721358679
  lifetime 228.53707765957046
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 42
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 20
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 13
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 12
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 31
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 21
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 28
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 46
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 36
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 41
    gpu 46
    rom 32
  ]
  node [
    id 10
    label "10"
    cpu 46
    gpu 38
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 4
    gpu 25
    rom 31
  ]
  node [
    id 12
    label "12"
    cpu 15
    gpu 8
    rom 11
  ]
  node [
    id 13
    label "13"
    cpu 20
    gpu 4
    rom 16
  ]
  node [
    id 14
    label "14"
    cpu 28
    gpu 2
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 11
  ]
  edge [
    source 10
    target 11
    bw 10
  ]
  edge [
    source 11
    target 12
    bw 12
  ]
  edge [
    source 12
    target 13
    bw 0
  ]
  edge [
    source 13
    target 14
    bw 24
  ]
]
