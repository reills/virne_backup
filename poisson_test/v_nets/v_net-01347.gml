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
  id 1347
  arrival_time 28569.9668757482
  lifetime 190.74752973640653
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 25
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 18
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
]
