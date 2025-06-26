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
  id 1028
  arrival_time 21855.83430909581
  lifetime 2027.7074180075272
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 27
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 46
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 22
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
]
