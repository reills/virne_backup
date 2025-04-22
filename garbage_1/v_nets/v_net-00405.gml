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
  id 405
  arrival_time 8030.757442153987
  lifetime 1485.7092170206631
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 43
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 28
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 12
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 23
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
]
