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
  id 1266
  arrival_time 26612.920948252304
  lifetime 2664.166826429877
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 22
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 18
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 1
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 47
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
]
