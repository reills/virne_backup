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
  id 1265
  arrival_time 26587.366362425357
  lifetime 971.7163582677179
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 9
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 29
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 40
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 14
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 32
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 42
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 46
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 5
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 2
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 48
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 45
    gpu 6
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 20
    gpu 47
    rom 33
  ]
  node [
    id 12
    label "12"
    cpu 34
    gpu 19
    rom 47
  ]
  node [
    id 13
    label "13"
    cpu 12
    gpu 21
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 5
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
  edge [
    source 11
    target 12
    bw 9
  ]
  edge [
    source 12
    target 13
    bw 15
  ]
]
