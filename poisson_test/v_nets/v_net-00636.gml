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
  id 636
  arrival_time 13332.862915517851
  lifetime 1669.5343690031966
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 21
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 43
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 12
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 10
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 18
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 4
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 29
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 9
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 30
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 16
    rom 18
  ]
  node [
    id 10
    label "10"
    cpu 31
    gpu 13
    rom 11
  ]
  node [
    id 11
    label "11"
    cpu 39
    gpu 48
    rom 29
  ]
  node [
    id 12
    label "12"
    cpu 38
    gpu 37
    rom 37
  ]
  node [
    id 13
    label "13"
    cpu 9
    gpu 36
    rom 17
  ]
  node [
    id 14
    label "14"
    cpu 15
    gpu 6
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 8
  ]
  edge [
    source 11
    target 12
    bw 50
  ]
  edge [
    source 12
    target 13
    bw 25
  ]
  edge [
    source 13
    target 14
    bw 8
  ]
]
