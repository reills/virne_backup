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
  id 1114
  arrival_time 23202.877339790848
  lifetime 302.4170097764944
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 23
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 14
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 27
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 26
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 20
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 7
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 23
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 13
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 21
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 17
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
]
