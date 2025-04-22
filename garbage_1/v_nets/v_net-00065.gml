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
  id 65
  arrival_time 1266.2387882511985
  lifetime 1404.6337420217565
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 2
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 18
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 1
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 39
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 14
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 40
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 49
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 47
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 30
    gpu 17
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 29
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 20
    gpu 24
    rom 40
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 37
    rom 34
  ]
  node [
    id 12
    label "12"
    cpu 28
    gpu 25
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 10
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
]
