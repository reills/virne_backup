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
  id 552
  arrival_time 10385.575054524472
  lifetime 244.8088176055019
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 5
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 39
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 17
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 6
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 8
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
]
