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
  id 1790
  arrival_time 39830.817050873615
  lifetime 1068.1004497831245
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 40
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 44
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 19
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 27
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 23
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 7
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 11
    rom 48
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 33
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
]
