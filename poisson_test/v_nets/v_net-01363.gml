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
  id 1363
  arrival_time 28834.470631683555
  lifetime 1212.6248266825826
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 6
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 36
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 16
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 49
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 11
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
]
