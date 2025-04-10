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
  id 1201
  arrival_time 25089.44193096301
  lifetime 1013.3224907289238
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 38
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 26
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 49
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 10
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 14
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
]
