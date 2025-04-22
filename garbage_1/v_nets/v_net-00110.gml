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
  id 110
  arrival_time 2025.0475190439768
  lifetime 1351.815672654041
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 4
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 33
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 50
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 31
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 20
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 4
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 9
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 6
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 0
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 5
    rom 6
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 8
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 17
    gpu 16
    rom 27
  ]
  node [
    id 12
    label "12"
    cpu 41
    gpu 4
    rom 0
  ]
  node [
    id 13
    label "13"
    cpu 18
    gpu 4
    rom 20
  ]
  node [
    id 14
    label "14"
    cpu 44
    gpu 23
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 20
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
  edge [
    source 10
    target 11
    bw 23
  ]
  edge [
    source 11
    target 12
    bw 29
  ]
  edge [
    source 12
    target 13
    bw 15
  ]
  edge [
    source 13
    target 14
    bw 24
  ]
]
