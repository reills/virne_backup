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
  id 878
  arrival_time 18325.343344933197
  lifetime 303.91706992876095
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 47
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 34
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 40
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 47
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
]
