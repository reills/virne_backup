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
  id 86
  arrival_time 1670.8684746370404
  lifetime 470.28173225580025
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 43
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 7
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 26
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 36
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 35
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 27
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 22
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 6
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
]
