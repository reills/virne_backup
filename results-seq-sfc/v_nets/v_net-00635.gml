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
  id 635
  arrival_time 13331.898638431387
  lifetime 1979.2962940325237
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 12
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 16
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 8
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 37
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 6
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 6
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 15
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
]
