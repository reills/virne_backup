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
  id 1292
  arrival_time 27069.820389476463
  lifetime 900.4264865565214
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 34
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 41
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 12
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 47
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 46
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 37
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 11
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
]
