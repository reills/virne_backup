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
  id 1724
  arrival_time 38529.01504259911
  lifetime 264.94140785848487
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 4
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 26
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 45
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 21
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 31
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 1
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 8
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 40
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 36
    gpu 10
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 45
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 7
    gpu 35
    rom 32
  ]
  node [
    id 11
    label "11"
    cpu 9
    gpu 23
    rom 12
  ]
  node [
    id 12
    label "12"
    cpu 8
    gpu 6
    rom 29
  ]
  node [
    id 13
    label "13"
    cpu 7
    gpu 26
    rom 3
  ]
  node [
    id 14
    label "14"
    cpu 2
    gpu 31
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 36
  ]
  edge [
    source 8
    target 9
    bw 19
  ]
  edge [
    source 9
    target 10
    bw 1
  ]
  edge [
    source 10
    target 11
    bw 30
  ]
  edge [
    source 11
    target 12
    bw 35
  ]
  edge [
    source 12
    target 13
    bw 6
  ]
  edge [
    source 13
    target 14
    bw 2
  ]
]
