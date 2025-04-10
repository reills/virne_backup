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
  id 1964
  arrival_time 42954.037596998154
  lifetime 1124.1849186307968
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 5
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 37
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 39
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
]
