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
  id 187
  arrival_time 3404.7848669592527
  lifetime 249.86555697183843
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 28
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 24
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 25
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 31
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 24
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 45
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 29
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 26
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
]
