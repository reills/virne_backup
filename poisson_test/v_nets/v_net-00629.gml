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
  id 629
  arrival_time 12925.757321671379
  lifetime 702.065754969773
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 6
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 27
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 23
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
]
