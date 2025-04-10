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
  id 228
  arrival_time 4185.018258718985
  lifetime 626.571260098399
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 16
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 13
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 13
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 12
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 5
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 28
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 16
    gpu 41
    rom 32
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 14
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 14
    rom 25
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 33
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 11
    gpu 44
    rom 30
  ]
  node [
    id 11
    label "11"
    cpu 21
    gpu 4
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 34
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
]
