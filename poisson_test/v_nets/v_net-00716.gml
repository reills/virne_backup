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
  id 716
  arrival_time 15020.504867772812
  lifetime 19.70512441406044
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 7
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 14
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 42
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 8
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
]
