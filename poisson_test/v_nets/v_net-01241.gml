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
  id 1241
  arrival_time 25576.02299468164
  lifetime 1881.6817107095103
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 30
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 15
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 47
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 25
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 24
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 25
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
]
