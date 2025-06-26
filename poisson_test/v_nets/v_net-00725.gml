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
  id 725
  arrival_time 15288.621646525475
  lifetime 2111.5040664605363
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 46
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 25
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 0
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 44
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 12
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 45
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 15
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
]
