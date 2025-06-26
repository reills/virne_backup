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
  id 1902
  arrival_time 41953.28710711188
  lifetime 358.4517600481447
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 35
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 16
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 33
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
]
