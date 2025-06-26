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
  id 615
  arrival_time 12794.326401796468
  lifetime 481.57025653038414
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 20
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 4
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
]
