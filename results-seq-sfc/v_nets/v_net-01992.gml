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
  id 1992
  arrival_time 43443.29436969311
  lifetime 591.0298834140093
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 7
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 16
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 16
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 36
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 49
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
]
