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
  id 280
  arrival_time 5389.497097936715
  lifetime 2182.299533166358
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 17
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 12
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 43
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 43
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 26
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 47
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 8
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
]
