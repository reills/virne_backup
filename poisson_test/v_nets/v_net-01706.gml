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
  id 1706
  arrival_time 37785.64547342335
  lifetime 809.3232136244966
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 8
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 11
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 12
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 20
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 49
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 17
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 23
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
]
