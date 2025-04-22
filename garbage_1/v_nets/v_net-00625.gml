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
  id 625
  arrival_time 12855.214583341774
  lifetime 2801.3011669728025
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 40
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 5
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
]
