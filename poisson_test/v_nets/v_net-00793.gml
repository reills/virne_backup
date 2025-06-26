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
  id 793
  arrival_time 16622.444559188356
  lifetime 745.9235537471948
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 24
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 20
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 28
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
]
