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
  id 801
  arrival_time 16671.541115225915
  lifetime 517.1220294168977
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 28
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 1
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 0
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 38
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
]
