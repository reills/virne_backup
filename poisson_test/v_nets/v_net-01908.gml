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
  id 1908
  arrival_time 42019.44356186192
  lifetime 1436.4743235382025
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 32
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 27
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 27
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 25
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 6
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 48
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 0
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 33
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 32
    rom 16
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 34
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 27
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 32
    rom 37
  ]
  node [
    id 12
    label "12"
    cpu 30
    gpu 4
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 38
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
]
