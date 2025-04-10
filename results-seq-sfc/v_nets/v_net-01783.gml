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
  id 1783
  arrival_time 39758.005749772856
  lifetime 1856.6729364441169
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 15
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 24
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 1
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 48
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 36
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 4
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 2
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 13
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
]
