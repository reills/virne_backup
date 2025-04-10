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
  id 1300
  arrival_time 27105.283048187
  lifetime 2934.150897204707
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 49
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 25
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
]
