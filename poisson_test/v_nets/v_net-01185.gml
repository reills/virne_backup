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
  id 1185
  arrival_time 24430.12363305637
  lifetime 2122.316705567424
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 38
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 33
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 10
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 2
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 14
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 34
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
]
