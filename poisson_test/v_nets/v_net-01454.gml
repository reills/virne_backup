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
  id 1454
  arrival_time 30607.05037889831
  lifetime 441.0800313425318
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 49
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 23
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 17
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 37
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 46
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 36
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 33
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 10
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
]
