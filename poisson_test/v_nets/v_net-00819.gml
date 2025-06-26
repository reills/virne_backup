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
  id 819
  arrival_time 16884.999593038436
  lifetime 2445.045076478727
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 12
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 4
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 4
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 34
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
]
