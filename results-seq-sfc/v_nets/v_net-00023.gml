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
  id 23
  arrival_time 548.959423629616
  lifetime 1103.499313498231
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 36
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 42
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 26
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
]
