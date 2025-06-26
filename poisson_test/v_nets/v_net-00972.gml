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
  id 972
  arrival_time 20597.732655366395
  lifetime 4802.61111776484
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 8
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 23
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 39
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 13
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 40
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 27
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 33
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
]
