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
  id 1693
  arrival_time 37641.35220883741
  lifetime 1101.9837205472643
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 39
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 11
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 25
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 34
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 2
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 41
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 18
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 21
    rom 21
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 8
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 22
    rom 20
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 15
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
]
