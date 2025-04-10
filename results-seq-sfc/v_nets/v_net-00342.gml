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
  id 342
  arrival_time 6520.414559416937
  lifetime 1045.8927639836272
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 33
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 44
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 13
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
]
