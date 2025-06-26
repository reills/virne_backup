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
  id 1596
  arrival_time 35857.259029854875
  lifetime 2566.8368229643065
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 49
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 35
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 11
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
]
