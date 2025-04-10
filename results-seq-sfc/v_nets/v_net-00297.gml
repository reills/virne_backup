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
  id 297
  arrival_time 5709.028314346195
  lifetime 290.75364507336076
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 16
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 36
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
]
