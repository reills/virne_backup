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
  id 858
  arrival_time 17708.106429949083
  lifetime 134.46405898217546
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 2
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 22
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 38
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
]
