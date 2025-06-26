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
  id 1933
  arrival_time 42621.974032028906
  lifetime 712.2837455188319
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 32
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 7
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 48
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 30
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 26
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 45
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
    bw 13
  ]
]
