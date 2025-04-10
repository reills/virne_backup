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
  id 1339
  arrival_time 28392.08033728589
  lifetime 710.0009047579165
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 38
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 37
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 1
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 40
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 0
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 20
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
]
