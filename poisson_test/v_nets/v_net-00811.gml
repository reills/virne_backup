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
  id 811
  arrival_time 16811.730730111496
  lifetime 560.6821336674608
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 45
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 10
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 21
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 40
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 37
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
]
