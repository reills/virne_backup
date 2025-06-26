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
  id 1232
  arrival_time 25441.212689726042
  lifetime 4875.385848142855
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 19
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 44
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 33
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 46
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 25
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 30
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 41
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 11
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 5
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
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
]
