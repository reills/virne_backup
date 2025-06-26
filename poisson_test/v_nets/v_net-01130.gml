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
  id 1130
  arrival_time 23542.75522661783
  lifetime 7.219453645632016
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 46
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 45
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 5
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 39
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 7
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 28
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 13
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
]
