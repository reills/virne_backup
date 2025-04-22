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
  id 1580
  arrival_time 35600.160865882426
  lifetime 3952.922795896844
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 45
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 14
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 30
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 30
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 3
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 26
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 13
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
]
