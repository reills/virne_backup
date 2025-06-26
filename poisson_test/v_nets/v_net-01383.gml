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
  id 1383
  arrival_time 29238.9681917498
  lifetime 774.1515989753934
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 29
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 14
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 23
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 1
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 17
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 27
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 20
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 20
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 30
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
]
