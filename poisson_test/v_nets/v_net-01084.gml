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
  id 1084
  arrival_time 22632.069555464004
  lifetime 1274.2532651227568
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 2
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 32
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 0
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 41
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 15
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 12
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 45
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 33
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
]
