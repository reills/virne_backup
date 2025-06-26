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
  id 688
  arrival_time 14569.255558439481
  lifetime 111.96837264197433
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 16
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 15
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 45
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 34
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 43
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 30
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 23
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
]
