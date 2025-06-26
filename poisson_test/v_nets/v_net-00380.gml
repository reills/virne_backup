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
  id 380
  arrival_time 7548.24776449398
  lifetime 986.243160795252
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 6
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 20
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 23
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 35
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 6
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 33
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 24
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
]
