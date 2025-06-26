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
  id 1289
  arrival_time 26860.13522667404
  lifetime 1132.0638910451494
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 4
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 42
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 19
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 30
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 50
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 23
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 41
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
]
