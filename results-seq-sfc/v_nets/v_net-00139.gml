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
  id 139
  arrival_time 2389.2758365866002
  lifetime 848.5377288981523
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 4
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 5
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 6
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 13
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 36
    gpu 26
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 44
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
]
