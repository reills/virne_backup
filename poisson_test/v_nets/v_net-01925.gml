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
  id 1925
  arrival_time 42205.79461272797
  lifetime 952.673814978606
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 2
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 32
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 7
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 19
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 42
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
]
