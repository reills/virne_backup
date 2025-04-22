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
  id 660
  arrival_time 13959.671266921952
  lifetime 1207.512587511631
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 50
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 25
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 19
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 22
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 38
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 50
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
]
