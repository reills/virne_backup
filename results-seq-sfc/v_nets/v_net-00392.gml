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
  id 392
  arrival_time 7811.0083907490725
  lifetime 54.205052481052114
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 50
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 28
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 26
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 3
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 16
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 30
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
]
