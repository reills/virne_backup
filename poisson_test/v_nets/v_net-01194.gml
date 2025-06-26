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
  id 1194
  arrival_time 24713.617412937416
  lifetime 553.9615364300388
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 28
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 50
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 3
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 7
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 23
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 43
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 36
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 34
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 35
    gpu 19
    rom 16
  ]
  node [
    id 9
    label "9"
    cpu 10
    gpu 5
    rom 4
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 12
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 10
  ]
  edge [
    source 9
    target 10
    bw 35
  ]
]
