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
  id 1327
  arrival_time 27904.259485843304
  lifetime 906.70051256482
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 14
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 29
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
]
