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
  id 667
  arrival_time 14229.641899479995
  lifetime 1709.971429553222
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 24
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 5
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 36
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 1
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 23
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 31
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 12
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 14
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 17
    rom 46
  ]
  node [
    id 9
    label "9"
    cpu 14
    gpu 13
    rom 45
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 43
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 41
  ]
]
