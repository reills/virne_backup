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
  id 655
  arrival_time 13842.698453529296
  lifetime 501.122380421156
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 42
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 33
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 36
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 1
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 36
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 11
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 15
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
]
