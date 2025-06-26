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
  id 309
  arrival_time 5832.751038724527
  lifetime 261.92044535878387
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 19
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 29
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 11
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 31
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 39
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 9
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 6
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 42
    gpu 5
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
]
