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
  id 1251
  arrival_time 25909.380816925102
  lifetime 369.17488089640455
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 28
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 6
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
]
