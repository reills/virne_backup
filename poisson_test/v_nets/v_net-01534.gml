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
  id 1534
  arrival_time 33969.31500686193
  lifetime 402.149451359481
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 2
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 16
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 39
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 40
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 41
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 12
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 19
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 16
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 16
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 13
    gpu 8
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 20
    gpu 40
    rom 43
  ]
  node [
    id 11
    label "11"
    cpu 26
    gpu 16
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 42
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
]
