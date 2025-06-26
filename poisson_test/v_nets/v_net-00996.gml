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
  id 996
  arrival_time 21216.901304456744
  lifetime 2205.3228127208567
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 29
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 27
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
]
