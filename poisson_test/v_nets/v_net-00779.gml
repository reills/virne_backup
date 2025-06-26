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
  id 779
  arrival_time 16173.726586422568
  lifetime 791.206506988816
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 18
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 5
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 43
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 39
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 44
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 2
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
]
