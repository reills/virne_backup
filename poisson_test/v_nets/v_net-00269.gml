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
  id 269
  arrival_time 5242.461992506374
  lifetime 1092.9586928562005
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 47
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 16
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
]
