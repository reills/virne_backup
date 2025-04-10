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
  id 268
  arrival_time 5225.808611170109
  lifetime 949.5340415669074
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 6
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 10
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 48
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 26
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 16
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 46
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 48
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 40
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 41
    rom 28
  ]
  node [
    id 9
    label "9"
    cpu 9
    gpu 10
    rom 25
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 39
    rom 15
  ]
  node [
    id 11
    label "11"
    cpu 40
    gpu 0
    rom 2
  ]
  node [
    id 12
    label "12"
    cpu 0
    gpu 38
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
  edge [
    source 11
    target 12
    bw 23
  ]
]
