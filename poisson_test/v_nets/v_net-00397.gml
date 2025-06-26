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
  id 397
  arrival_time 7841.322534355906
  lifetime 36.07359502011042
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 0
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 43
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 12
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 24
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
]
