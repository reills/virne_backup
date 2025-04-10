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
  id 909
  arrival_time 19416.01895326175
  lifetime 355.37650366212165
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 18
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 25
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 14
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 34
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
]
