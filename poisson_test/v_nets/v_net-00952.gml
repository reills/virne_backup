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
  id 952
  arrival_time 20325.472117282166
  lifetime 235.9245120953955
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 36
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 50
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
]
