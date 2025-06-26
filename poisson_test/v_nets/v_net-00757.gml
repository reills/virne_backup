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
  id 757
  arrival_time 15986.795276218367
  lifetime 29.46656254707175
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 30
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 17
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 47
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
]
