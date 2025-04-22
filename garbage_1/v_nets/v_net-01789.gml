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
  id 1789
  arrival_time 39823.67327051603
  lifetime 568.1029103401008
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 21
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 8
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 46
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 5
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
]
