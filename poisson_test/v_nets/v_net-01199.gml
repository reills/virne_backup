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
  id 1199
  arrival_time 24731.624703406913
  lifetime 185.45197330736855
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 30
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 47
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
]
