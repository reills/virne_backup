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
  id 600
  arrival_time 12409.278763736895
  lifetime 27.228075541618054
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 8
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 1
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 8
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 24
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 35
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 48
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 15
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
]
