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
  id 349
  arrival_time 6619.579483109824
  lifetime 241.72281864169003
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 4
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 2
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 35
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 31
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 49
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 0
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 33
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 34
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
]
