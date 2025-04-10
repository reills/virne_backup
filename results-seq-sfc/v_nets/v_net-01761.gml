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
  id 1761
  arrival_time 39400.87927560171
  lifetime 812.3956473991873
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 5
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 28
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 46
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 9
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 36
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 8
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 21
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
]
