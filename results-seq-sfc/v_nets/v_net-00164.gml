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
  id 164
  arrival_time 3096.854223887084
  lifetime 1074.628491319944
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 36
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 26
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 19
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 41
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 39
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 0
    rom 20
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 10
    rom 32
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 48
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 29
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 23
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 21
    gpu 19
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 3
  ]
]
