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
  id 1587
  arrival_time 35768.490343089274
  lifetime 1144.2872931115426
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 4
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 14
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
]
