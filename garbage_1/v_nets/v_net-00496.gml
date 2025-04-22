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
  id 496
  arrival_time 9307.980126501796
  lifetime 1040.4961713182395
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 39
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 13
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 18
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
]
