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
  id 1636
  arrival_time 36644.19056512352
  lifetime 1109.8572082529179
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 6
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 16
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 49
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 14
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 20
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 17
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 43
    rom 32
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 49
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 38
    rom 23
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 21
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 7
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
]
