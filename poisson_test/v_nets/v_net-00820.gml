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
  id 820
  arrival_time 17046.178227502838
  lifetime 725.0174944011274
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 20
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 7
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 40
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 39
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 19
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 12
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 16
    gpu 23
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 32
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 43
    gpu 36
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
]
