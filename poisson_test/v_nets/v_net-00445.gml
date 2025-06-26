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
  id 445
  arrival_time 8574.406697337576
  lifetime 3999.079782600702
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 5
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 0
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 29
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 2
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 7
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
]
