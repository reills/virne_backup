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
  id 1542
  arrival_time 34026.05205056497
  lifetime 3836.8799884211153
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 2
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 11
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
]
