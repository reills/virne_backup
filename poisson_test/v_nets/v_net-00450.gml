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
  id 450
  arrival_time 8611.450605985248
  lifetime 2336.4713582999693
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 34
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 35
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
]
