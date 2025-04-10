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
  id 202
  arrival_time 3580.9753978248896
  lifetime 3004.1635764774705
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 32
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 23
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 39
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 26
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 26
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 14
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
]
