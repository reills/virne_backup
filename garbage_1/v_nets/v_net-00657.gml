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
  id 657
  arrival_time 13891.038826984319
  lifetime 1585.5228936660556
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 6
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 34
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 14
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 21
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 19
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 20
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 14
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 49
    gpu 15
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 35
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
]
