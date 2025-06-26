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
  id 1920
  arrival_time 42138.57202081575
  lifetime 1730.9343685945191
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 34
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 15
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 31
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 48
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 4
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 7
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
]
