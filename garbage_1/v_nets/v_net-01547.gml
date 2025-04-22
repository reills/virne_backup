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
  id 1547
  arrival_time 34168.48472346419
  lifetime 577.051230704513
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 2
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 15
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 24
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 43
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
]
