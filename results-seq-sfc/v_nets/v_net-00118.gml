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
  id 118
  arrival_time 2147.468402588706
  lifetime 4977.797788359445
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 31
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 49
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 24
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 28
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
]
