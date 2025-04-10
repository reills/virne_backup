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
  id 412
  arrival_time 8110.0812404381695
  lifetime 94.09713022329389
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 8
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 0
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 37
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
]
