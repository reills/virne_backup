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
  id 63
  arrival_time 1253.5127945221993
  lifetime 1715.3589456167895
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 49
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 6
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 46
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 9
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 17
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 34
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
]
