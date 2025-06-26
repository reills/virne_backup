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
  id 1539
  arrival_time 34005.67282337303
  lifetime 521.0669582375629
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 5
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 31
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 19
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 31
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 10
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 22
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 47
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 15
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 49
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
]
