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
  id 56
  arrival_time 1147.84549505694
  lifetime 261.1034254954281
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 25
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 13
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 26
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 11
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 26
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 43
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 24
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 2
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 43
    rom 12
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 32
    rom 32
  ]
  node [
    id 10
    label "10"
    cpu 45
    gpu 11
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 16
  ]
]
