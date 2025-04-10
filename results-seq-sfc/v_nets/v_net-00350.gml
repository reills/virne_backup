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
  id 350
  arrival_time 6629.391106750076
  lifetime 1654.6412826569983
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 12
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 36
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 47
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 33
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 42
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 6
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 19
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
]
