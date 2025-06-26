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
  id 1607
  arrival_time 35959.38847385322
  lifetime 1918.5391909031518
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 39
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 8
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 31
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 21
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
]
