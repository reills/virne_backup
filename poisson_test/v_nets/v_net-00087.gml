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
  id 87
  arrival_time 1690.4525955922077
  lifetime 411.6353899933859
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 30
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 17
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 18
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 0
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 35
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
]
