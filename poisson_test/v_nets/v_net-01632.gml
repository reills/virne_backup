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
  id 1632
  arrival_time 36611.5283416796
  lifetime 354.1925176000949
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 14
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 16
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 31
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 50
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 36
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 25
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
]
