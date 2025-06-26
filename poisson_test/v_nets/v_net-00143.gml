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
  id 143
  arrival_time 2547.021977283635
  lifetime 1994.6676793394017
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 28
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 0
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 43
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 42
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 24
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 48
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 24
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
]
