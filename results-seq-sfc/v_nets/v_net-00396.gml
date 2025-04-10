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
  id 396
  arrival_time 7840.190023714462
  lifetime 646.3731650913734
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 25
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 3
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 47
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 35
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 33
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 25
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 28
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
]
