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
  id 804
  arrival_time 16695.517368557656
  lifetime 1146.6820312132686
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 48
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 2
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 31
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 30
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
]
