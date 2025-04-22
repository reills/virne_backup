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
  id 270
  arrival_time 5245.050700516647
  lifetime 646.9362258315674
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 22
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 42
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 35
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 18
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 22
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 17
    gpu 30
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 15
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
]
