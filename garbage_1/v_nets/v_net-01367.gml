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
  id 1367
  arrival_time 28905.8359240431
  lifetime 26.175896310317295
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 27
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 28
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
]
