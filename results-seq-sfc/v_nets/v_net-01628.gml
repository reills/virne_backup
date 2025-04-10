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
  id 1628
  arrival_time 36535.32039892725
  lifetime 639.4009337267951
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 44
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 48
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 15
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
]
