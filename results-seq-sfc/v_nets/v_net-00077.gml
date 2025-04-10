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
  id 77
  arrival_time 1605.4252717449813
  lifetime 14.015323720407704
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 27
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 7
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 36
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 7
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 46
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 28
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 17
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 34
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 16
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
]
