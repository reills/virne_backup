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
  id 979
  arrival_time 20870.44531093098
  lifetime 855.1468543360687
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 0
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 21
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 48
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 19
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 45
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 47
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 17
    rom 0
  ]
  node [
    id 7
    label "7"
    cpu 42
    gpu 16
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 27
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 9
    gpu 16
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 21
    gpu 14
    rom 8
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 39
    rom 44
  ]
  node [
    id 12
    label "12"
    cpu 31
    gpu 43
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 5
  ]
  edge [
    source 10
    target 11
    bw 28
  ]
  edge [
    source 11
    target 12
    bw 19
  ]
]
