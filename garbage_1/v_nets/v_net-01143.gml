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
  id 1143
  arrival_time 23919.657577083955
  lifetime 3029.200971302179
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 13
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 22
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 49
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 6
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 22
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 8
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 13
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 50
    gpu 11
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 26
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 22
    rom 27
  ]
  node [
    id 10
    label "10"
    cpu 31
    gpu 11
    rom 5
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 19
    rom 14
  ]
  node [
    id 12
    label "12"
    cpu 21
    gpu 49
    rom 46
  ]
  node [
    id 13
    label "13"
    cpu 48
    gpu 18
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
  edge [
    source 12
    target 13
    bw 20
  ]
]
