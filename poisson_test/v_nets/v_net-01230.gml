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
  id 1230
  arrival_time 25435.491715366956
  lifetime 61.824281513281626
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 37
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 35
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 22
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 16
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
]
