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
  id 1642
  arrival_time 36685.87566583928
  lifetime 1559.3978549101114
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 49
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 43
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 42
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 16
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 22
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 8
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 43
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 7
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 33
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 22
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 9
    gpu 11
    rom 26
  ]
  node [
    id 11
    label "11"
    cpu 4
    gpu 14
    rom 7
  ]
  node [
    id 12
    label "12"
    cpu 32
    gpu 20
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
  edge [
    source 9
    target 10
    bw 46
  ]
  edge [
    source 10
    target 11
    bw 4
  ]
  edge [
    source 11
    target 12
    bw 20
  ]
]
