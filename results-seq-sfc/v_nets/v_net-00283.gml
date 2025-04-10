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
  id 283
  arrival_time 5488.028256740372
  lifetime 1053.1067648014719
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 35
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 40
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 16
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 31
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 12
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 30
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 32
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 49
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 20
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
]
