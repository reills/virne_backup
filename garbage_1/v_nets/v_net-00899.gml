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
  id 899
  arrival_time 19283.65278278702
  lifetime 111.40876106124557
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 42
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 2
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 36
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 13
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 1
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 16
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
]
