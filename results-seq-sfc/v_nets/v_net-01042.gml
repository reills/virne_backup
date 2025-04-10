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
  id 1042
  arrival_time 22080.4641957439
  lifetime 292.2916165020727
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 46
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 26
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 20
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 5
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 48
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 6
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
]
