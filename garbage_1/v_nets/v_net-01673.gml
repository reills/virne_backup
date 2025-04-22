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
  id 1673
  arrival_time 37301.41972164054
  lifetime 1595.5046306425777
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 32
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 50
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 27
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 39
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 38
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 24
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 21
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
]
