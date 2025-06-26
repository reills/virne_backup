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
  id 1589
  arrival_time 35794.20068910143
  lifetime 1023.9797986782104
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 47
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 40
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 1
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 40
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 48
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 48
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 6
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 34
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 29
    rom 32
  ]
  node [
    id 9
    label "9"
    cpu 40
    gpu 26
    rom 50
  ]
  node [
    id 10
    label "10"
    cpu 42
    gpu 40
    rom 30
  ]
  node [
    id 11
    label "11"
    cpu 26
    gpu 37
    rom 43
  ]
  node [
    id 12
    label "12"
    cpu 39
    gpu 25
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 7
  ]
  edge [
    source 9
    target 10
    bw 31
  ]
  edge [
    source 10
    target 11
    bw 46
  ]
  edge [
    source 11
    target 12
    bw 23
  ]
]
