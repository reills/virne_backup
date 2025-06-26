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
  id 1760
  arrival_time 39396.34329184706
  lifetime 576.4146373735902
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 7
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 13
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 9
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 50
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
]
