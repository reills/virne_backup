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
  id 1278
  arrival_time 26758.40112379002
  lifetime 1263.6821502839518
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 42
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 29
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 42
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 40
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 42
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 35
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 18
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 4
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 1
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 48
    rom 6
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 27
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 30
    gpu 29
    rom 5
  ]
  node [
    id 12
    label "12"
    cpu 11
    gpu 32
    rom 0
  ]
  node [
    id 13
    label "13"
    cpu 13
    gpu 4
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
  edge [
    source 10
    target 11
    bw 9
  ]
  edge [
    source 11
    target 12
    bw 29
  ]
  edge [
    source 12
    target 13
    bw 5
  ]
]
