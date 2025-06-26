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
  id 1429
  arrival_time 29955.254500968855
  lifetime 1908.9862588768117
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 48
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 21
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 39
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 29
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 21
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
]
