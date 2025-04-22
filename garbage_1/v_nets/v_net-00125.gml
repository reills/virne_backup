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
  id 125
  arrival_time 2207.675194081027
  lifetime 1696.7929934486533
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 42
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 12
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 17
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 17
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 21
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 46
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 24
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 43
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 11
    gpu 23
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 18
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 36
  ]
]
