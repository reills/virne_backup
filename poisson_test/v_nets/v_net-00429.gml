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
  id 429
  arrival_time 8372.491455686431
  lifetime 393.25502032006364
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 34
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 26
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 23
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 11
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 5
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 8
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 38
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 50
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 26
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 39
  ]
]
