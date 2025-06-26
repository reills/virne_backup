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
  id 1135
  arrival_time 23617.138067687272
  lifetime 2741.0480445030826
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 15
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 28
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 39
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 31
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 35
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 24
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 50
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
]
