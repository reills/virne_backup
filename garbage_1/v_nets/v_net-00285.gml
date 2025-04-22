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
  id 285
  arrival_time 5523.3996362958305
  lifetime 1266.5328747594062
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 13
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 17
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 2
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 10
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 50
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 17
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 27
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 13
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 14
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
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
]
