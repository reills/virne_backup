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
  id 80
  arrival_time 1628.8304145905038
  lifetime 404.9531702387096
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 43
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 49
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 0
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 21
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 23
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 16
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 5
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 23
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 30
    gpu 13
    rom 6
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 23
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 40
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
]
