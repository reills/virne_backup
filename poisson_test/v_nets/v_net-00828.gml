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
  id 828
  arrival_time 17109.290673798478
  lifetime 2332.71740098815
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 35
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 15
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 20
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 13
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 5
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 37
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
]
