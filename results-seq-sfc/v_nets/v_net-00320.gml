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
  id 320
  arrival_time 6088.2960401309165
  lifetime 2202.076074952116
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 8
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 33
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 23
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 40
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
]
