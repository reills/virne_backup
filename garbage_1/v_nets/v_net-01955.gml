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
  id 1955
  arrival_time 42854.20514853695
  lifetime 344.2968973909188
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 13
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 4
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 9
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 21
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 24
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 43
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 20
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 28
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 5
    rom 47
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 50
    rom 50
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 23
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 23
  ]
]
