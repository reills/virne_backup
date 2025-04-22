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
  id 540
  arrival_time 10256.046257427259
  lifetime 520.4737502632983
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 13
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 38
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 15
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 4
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 37
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 31
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 12
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 43
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 33
    gpu 13
    rom 37
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 40
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 41
    rom 35
  ]
  node [
    id 11
    label "11"
    cpu 9
    gpu 22
    rom 1
  ]
  node [
    id 12
    label "12"
    cpu 32
    gpu 20
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
  edge [
    source 10
    target 11
    bw 27
  ]
  edge [
    source 11
    target 12
    bw 13
  ]
]
