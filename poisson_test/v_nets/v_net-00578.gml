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
  id 578
  arrival_time 10778.210594638413
  lifetime 835.271599334389
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 7
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 14
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 27
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 35
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 33
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 44
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 9
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 43
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
]
