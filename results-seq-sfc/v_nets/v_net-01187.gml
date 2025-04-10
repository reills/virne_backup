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
  id 1187
  arrival_time 24595.07083682199
  lifetime 2484.502977010627
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 4
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 15
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 8
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 6
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 43
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 47
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 30
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
]
