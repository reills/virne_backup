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
  id 1103
  arrival_time 22999.328979194324
  lifetime 1270.7991302678345
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 20
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 35
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 1
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 8
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 50
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 46
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 16
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 15
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 18
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 31
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 29
    rom 24
  ]
  node [
    id 11
    label "11"
    cpu 39
    gpu 50
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
  edge [
    source 10
    target 11
    bw 49
  ]
]
