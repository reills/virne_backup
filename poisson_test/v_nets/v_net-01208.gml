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
  id 1208
  arrival_time 25146.198728379633
  lifetime 1631.7398984081049
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 37
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 39
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 33
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 2
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 17
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
]
