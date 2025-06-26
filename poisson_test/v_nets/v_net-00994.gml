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
  id 994
  arrival_time 21176.929580431388
  lifetime 532.045017394514
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 37
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 23
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
]
