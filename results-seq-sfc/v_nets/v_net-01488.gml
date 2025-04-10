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
  id 1488
  arrival_time 32941.49824469944
  lifetime 1411.5058410376548
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 14
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 14
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 13
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 13
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 40
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 23
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 14
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
]
