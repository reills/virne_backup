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
  id 1518
  arrival_time 33732.953430147325
  lifetime 1993.3413448352596
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 41
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 24
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 26
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 22
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 50
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 6
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 43
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 47
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 35
  ]
]
