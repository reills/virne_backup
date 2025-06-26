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
  id 124
  arrival_time 2202.9431577702835
  lifetime 569.1058350841926
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 50
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 48
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 11
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 0
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 37
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 8
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 38
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 23
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 45
    rom 23
  ]
  node [
    id 9
    label "9"
    cpu 17
    gpu 44
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
]
