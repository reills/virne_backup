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
  id 1036
  arrival_time 21916.11389615712
  lifetime 1157.386980015367
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 50
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 34
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 10
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 22
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
]
