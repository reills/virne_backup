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
  id 1247
  arrival_time 25784.702549765152
  lifetime 494.85879430580866
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 35
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 16
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 1
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
]
