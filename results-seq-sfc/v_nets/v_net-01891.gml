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
  id 1891
  arrival_time 41687.66451682069
  lifetime 281.11207171504054
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 13
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 37
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 41
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 6
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 0
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
]
