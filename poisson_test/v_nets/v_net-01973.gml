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
  id 1973
  arrival_time 43060.85725300556
  lifetime 1785.143914607581
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 44
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 47
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 28
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 5
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 11
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 17
    gpu 35
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 41
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
]
