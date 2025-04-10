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
  id 997
  arrival_time 21217.714103200113
  lifetime 523.0546562784084
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 34
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 46
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 18
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 48
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 9
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 8
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 15
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 3
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 45
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 11
    rom 21
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 32
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
]
