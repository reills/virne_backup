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
  id 1900
  arrival_time 41926.88948854326
  lifetime 1636.2917679096604
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 42
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 38
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
]
