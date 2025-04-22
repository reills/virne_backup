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
  id 382
  arrival_time 7597.015212403475
  lifetime 338.77895643014534
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 0
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 46
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 21
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 7
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
]
