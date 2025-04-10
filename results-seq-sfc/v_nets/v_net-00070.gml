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
  id 70
  arrival_time 1303.2322098225613
  lifetime 1693.8459405310898
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 35
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 43
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
]
