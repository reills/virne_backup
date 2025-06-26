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
  id 133
  arrival_time 2327.9040352093057
  lifetime 496.1149917147203
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 39
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 33
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
]
