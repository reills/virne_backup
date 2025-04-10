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
  id 513
  arrival_time 9783.76765293637
  lifetime 1209.4056375465846
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 37
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 10
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 46
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 50
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 24
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 21
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 18
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
]
