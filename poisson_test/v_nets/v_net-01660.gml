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
  id 1660
  arrival_time 37070.916403228686
  lifetime 1081.9447235727484
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 6
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 14
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 29
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 3
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 45
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 6
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 23
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 26
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 10
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
]
