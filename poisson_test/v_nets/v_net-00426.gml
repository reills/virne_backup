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
  id 426
  arrival_time 8342.835893399326
  lifetime 441.0830359620827
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 6
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 33
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 46
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 30
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 9
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 46
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 33
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 2
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
]
