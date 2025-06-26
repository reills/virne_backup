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
  id 1100
  arrival_time 22903.909509649653
  lifetime 912.9768289796332
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 0
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 5
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 23
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 37
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 34
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 3
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 16
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 7
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 44
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 35
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 16
    gpu 45
    rom 17
  ]
  node [
    id 11
    label "11"
    cpu 34
    gpu 15
    rom 14
  ]
  node [
    id 12
    label "12"
    cpu 12
    gpu 15
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 23
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 37
  ]
  edge [
    source 11
    target 12
    bw 9
  ]
]
