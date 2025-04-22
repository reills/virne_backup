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
  id 987
  arrival_time 21000.159019046452
  lifetime 1352.3484507083529
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 9
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 45
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 10
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 41
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
]
