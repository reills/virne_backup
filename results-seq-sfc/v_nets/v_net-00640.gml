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
  id 640
  arrival_time 13361.497420820735
  lifetime 140.07199289736263
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 50
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 37
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 2
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
]
