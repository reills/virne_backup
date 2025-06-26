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
  id 381
  arrival_time 7554.379642664117
  lifetime 660.5407223585119
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 17
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 28
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 3
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 48
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 25
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
]
