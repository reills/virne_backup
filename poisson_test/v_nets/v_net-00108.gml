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
  id 108
  arrival_time 2019.2146388522447
  lifetime 620.1026625750927
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 32
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 36
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 37
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 39
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 29
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 0
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
]
