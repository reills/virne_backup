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
  id 1450
  arrival_time 30581.518153735018
  lifetime 60.63746514468133
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 10
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 43
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 18
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 11
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 13
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
]
