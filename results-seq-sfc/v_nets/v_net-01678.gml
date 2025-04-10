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
  id 1678
  arrival_time 37338.43680075701
  lifetime 1601.8497607949944
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 48
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 30
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 15
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 13
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 24
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
]
