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
  id 1764
  arrival_time 39420.939737173016
  lifetime 113.51283401915758
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 26
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 34
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 10
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 48
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 12
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 18
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 6
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
]
