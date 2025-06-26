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
  id 969
  arrival_time 20541.612752104145
  lifetime 1522.4540587712756
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 13
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 39
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 46
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 31
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 46
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
]
