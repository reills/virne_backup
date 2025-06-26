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
  id 534
  arrival_time 10166.444433363036
  lifetime 1138.317599459548
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 0
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 22
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
]
