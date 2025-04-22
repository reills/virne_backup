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
  id 245
  arrival_time 4544.728100678098
  lifetime 1414.0057569555051
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 3
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 33
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 41
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 3
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 23
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 44
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 29
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 17
    rom 3
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 1
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 37
    rom 21
  ]
  node [
    id 10
    label "10"
    cpu 35
    gpu 43
    rom 39
  ]
  node [
    id 11
    label "11"
    cpu 21
    gpu 12
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 0
  ]
]
