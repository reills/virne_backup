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
  id 1269
  arrival_time 26628.880868421955
  lifetime 589.6419356309401
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 29
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 43
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
]
