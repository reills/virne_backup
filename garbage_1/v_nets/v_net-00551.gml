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
  id 551
  arrival_time 10372.460221419058
  lifetime 504.229105219551
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 11
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 42
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 21
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
]
