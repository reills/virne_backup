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
  id 1571
  arrival_time 35059.50172540686
  lifetime 1690.8328160187782
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 17
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 25
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 14
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 20
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 8
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
]
