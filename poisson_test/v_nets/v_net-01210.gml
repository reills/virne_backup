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
  id 1210
  arrival_time 25154.906643372477
  lifetime 283.54437853494096
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 34
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 26
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 17
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 9
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
]
