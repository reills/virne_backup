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
  id 1419
  arrival_time 29663.28878226577
  lifetime 2448.234631283742
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 5
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 9
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 25
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 50
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 15
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 38
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 27
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 28
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 46
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 34
    rom 4
  ]
  node [
    id 10
    label "10"
    cpu 32
    gpu 2
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 39
    gpu 35
    rom 30
  ]
  node [
    id 12
    label "12"
    cpu 22
    gpu 29
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
  edge [
    source 11
    target 12
    bw 33
  ]
]
