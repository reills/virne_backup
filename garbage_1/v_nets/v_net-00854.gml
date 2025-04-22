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
  id 854
  arrival_time 17652.419629026863
  lifetime 299.167902138368
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 39
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 41
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 26
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
]
