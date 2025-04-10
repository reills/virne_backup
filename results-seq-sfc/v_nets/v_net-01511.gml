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
  id 1511
  arrival_time 33602.91658028386
  lifetime 1544.9520317552956
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 17
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 36
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 4
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 15
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 31
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 48
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 14
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
]
