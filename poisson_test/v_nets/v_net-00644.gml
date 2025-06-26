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
  id 644
  arrival_time 13390.5267920771
  lifetime 569.4373380794484
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 17
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 32
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 0
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 1
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 10
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 17
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 50
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 25
    rom 3
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 12
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
]
