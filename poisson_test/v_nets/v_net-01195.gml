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
  id 1195
  arrival_time 24714.769781531457
  lifetime 872.752872882256
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 41
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 20
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 7
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 35
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 34
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 49
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 0
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
]
