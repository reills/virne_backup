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
  id 1244
  arrival_time 25694.637761095513
  lifetime 4621.614033079026
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 36
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 22
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 7
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 39
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 30
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 49
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 23
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 8
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 21
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
]
