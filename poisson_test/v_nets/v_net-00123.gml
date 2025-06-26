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
  id 123
  arrival_time 2178.508269217253
  lifetime 570.6289830813129
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 6
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 25
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 15
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 48
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 24
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 18
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 28
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 9
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 34
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 42
    rom 3
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 8
    rom 49
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 8
    rom 32
  ]
  node [
    id 12
    label "12"
    cpu 21
    gpu 43
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
  edge [
    source 10
    target 11
    bw 40
  ]
  edge [
    source 11
    target 12
    bw 19
  ]
]
