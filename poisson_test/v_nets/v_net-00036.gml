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
  id 36
  arrival_time 612.0003754410819
  lifetime 123.68485910432595
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 17
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 19
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 23
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 22
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 1
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 48
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 19
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 16
    rom 26
  ]
  node [
    id 8
    label "8"
    cpu 43
    gpu 35
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 9
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 15
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
]
