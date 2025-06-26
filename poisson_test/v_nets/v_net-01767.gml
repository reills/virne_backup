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
  id 1767
  arrival_time 39442.44307094967
  lifetime 5.135036224381124
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 5
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 4
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 15
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 11
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
]
