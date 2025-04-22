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
  id 1517
  arrival_time 33722.68390442532
  lifetime 1132.4972447770938
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 36
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 45
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 9
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 10
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 14
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 19
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 11
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 42
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 3
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 31
    rom 16
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 4
    rom 14
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 28
    rom 5
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 38
    rom 14
  ]
  node [
    id 13
    label "13"
    cpu 43
    gpu 17
    rom 46
  ]
  node [
    id 14
    label "14"
    cpu 25
    gpu 15
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
  edge [
    source 11
    target 12
    bw 18
  ]
  edge [
    source 12
    target 13
    bw 42
  ]
  edge [
    source 13
    target 14
    bw 4
  ]
]
