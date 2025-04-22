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
  id 1516
  arrival_time 33671.90357938632
  lifetime 21.588242102443637
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 7
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 36
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 18
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 7
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 45
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 38
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 33
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
]
