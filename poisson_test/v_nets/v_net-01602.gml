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
  id 1602
  arrival_time 35892.620142138185
  lifetime 841.392023983864
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 17
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 10
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 5
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 42
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 21
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 50
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 27
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 10
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 0
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 30
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
]
