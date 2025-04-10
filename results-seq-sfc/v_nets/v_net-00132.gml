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
  id 132
  arrival_time 2326.879296830412
  lifetime 299.8813319017387
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 35
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 31
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 4
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 47
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 40
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
]
