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
  id 42
  arrival_time 794.2850580955852
  lifetime 173.23648704303898
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 20
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 25
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 44
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 20
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 25
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 28
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
]
