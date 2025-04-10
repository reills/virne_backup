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
  id 616
  arrival_time 12795.487683576292
  lifetime 887.6836882577085
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 28
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 9
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 4
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 43
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 16
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 48
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 28
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
]
