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
  id 1227
  arrival_time 25401.82798858989
  lifetime 1203.1536715064196
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 48
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 2
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 10
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
]
