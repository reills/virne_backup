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
  id 739
  arrival_time 15490.512876774003
  lifetime 105.78228436794399
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 14
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 11
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 47
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 32
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 24
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 34
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 17
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 8
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 42
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 13
    rom 22
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 3
    rom 14
  ]
  node [
    id 11
    label "11"
    cpu 1
    gpu 38
    rom 27
  ]
  node [
    id 12
    label "12"
    cpu 21
    gpu 27
    rom 35
  ]
  node [
    id 13
    label "13"
    cpu 17
    gpu 48
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 2
  ]
  edge [
    source 10
    target 11
    bw 35
  ]
  edge [
    source 11
    target 12
    bw 30
  ]
  edge [
    source 12
    target 13
    bw 0
  ]
]
