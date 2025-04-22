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
  id 816
  arrival_time 16845.384353147987
  lifetime 382.7569976882577
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 17
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 33
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 8
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 14
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
]
