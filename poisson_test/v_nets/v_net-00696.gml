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
  id 696
  arrival_time 14699.68025844423
  lifetime 63.451403438313946
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 48
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 36
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
]
