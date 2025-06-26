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
  id 1273
  arrival_time 26712.660673193805
  lifetime 115.68858421131966
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 32
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 49
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 47
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 45
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 34
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 11
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 31
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 2
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 27
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 9
    gpu 38
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 17
    gpu 29
    rom 22
  ]
  node [
    id 11
    label "11"
    cpu 16
    gpu 32
    rom 13
  ]
  node [
    id 12
    label "12"
    cpu 23
    gpu 47
    rom 31
  ]
  node [
    id 13
    label "13"
    cpu 20
    gpu 38
    rom 6
  ]
  node [
    id 14
    label "14"
    cpu 27
    gpu 50
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 6
  ]
  edge [
    source 9
    target 10
    bw 0
  ]
  edge [
    source 10
    target 11
    bw 21
  ]
  edge [
    source 11
    target 12
    bw 4
  ]
  edge [
    source 12
    target 13
    bw 4
  ]
  edge [
    source 13
    target 14
    bw 9
  ]
]
