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
  id 1835
  arrival_time 40517.775698633835
  lifetime 1270.232691975949
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 6
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 24
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 20
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 26
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 50
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
]
