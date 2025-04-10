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
  id 1922
  arrival_time 42162.74332950252
  lifetime 42.085966685642255
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 49
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 6
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
]
