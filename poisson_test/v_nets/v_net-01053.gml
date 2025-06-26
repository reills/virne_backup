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
  id 1053
  arrival_time 22179.792371216456
  lifetime 103.71965099214047
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 49
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 26
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 13
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 50
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 30
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 44
    rom 23
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 42
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 34
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 43
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 21
    gpu 14
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 36
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
]
