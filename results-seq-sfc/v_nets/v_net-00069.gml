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
  id 69
  arrival_time 1302.8772513613778
  lifetime 372.5844209036118
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 44
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 23
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
]
