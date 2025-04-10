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
  id 389
  arrival_time 7728.194765166129
  lifetime 1201.1071978425978
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 37
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 3
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 24
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 0
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 34
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 19
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 32
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 40
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 38
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
]
