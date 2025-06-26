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
  id 907
  arrival_time 19345.65420795216
  lifetime 5338.894266518999
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 35
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 8
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 12
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 17
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 45
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 29
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 21
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 49
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 37
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 49
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
]
