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
  id 1475
  arrival_time 32094.042419745587
  lifetime 2802.604683647348
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 8
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 47
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 8
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
]
