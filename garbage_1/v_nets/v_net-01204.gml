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
  id 1204
  arrival_time 25112.97121049464
  lifetime 1763.5180940519822
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 11
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 16
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 32
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 36
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 11
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 42
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
]
