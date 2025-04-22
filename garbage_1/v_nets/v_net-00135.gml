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
  id 135
  arrival_time 2334.05048730731
  lifetime 1900.5024920652247
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 41
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 43
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 46
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 37
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 33
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 46
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
]
