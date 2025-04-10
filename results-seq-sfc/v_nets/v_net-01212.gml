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
  id 1212
  arrival_time 25228.61300222089
  lifetime 175.30979946911924
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 17
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 31
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 22
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 34
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 48
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 31
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 3
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 22
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 33
    gpu 47
    rom 32
  ]
  node [
    id 9
    label "9"
    cpu 41
    gpu 31
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
]
