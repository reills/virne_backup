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
  id 1198
  arrival_time 24729.506146362426
  lifetime 1724.0393802326482
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 40
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 17
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
]
