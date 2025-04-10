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
  id 1535
  arrival_time 33971.606315601486
  lifetime 1904.8153871948412
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 15
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 0
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 21
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 3
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 19
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 1
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
]
