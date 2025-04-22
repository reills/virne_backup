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
  id 753
  arrival_time 15930.37435176194
  lifetime 585.9989917649254
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 35
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 21
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
]
