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
  id 249
  arrival_time 4752.1321007607285
  lifetime 739.5506685981281
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 40
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 4
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 10
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 4
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
]
