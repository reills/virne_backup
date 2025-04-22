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
  id 1072
  arrival_time 22471.010470724854
  lifetime 2051.0639920427234
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 32
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 2
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 0
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 40
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 0
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 1
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 45
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 10
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 13
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 38
  ]
]
