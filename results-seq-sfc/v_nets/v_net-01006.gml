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
  id 1006
  arrival_time 21528.91553164534
  lifetime 1383.7497113098493
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 33
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 48
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 10
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 44
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 16
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 24
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 19
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 34
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 41
    rom 12
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 30
    rom 45
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 16
    rom 26
  ]
  node [
    id 11
    label "11"
    cpu 33
    gpu 14
    rom 14
  ]
  node [
    id 12
    label "12"
    cpu 39
    gpu 48
    rom 16
  ]
  node [
    id 13
    label "13"
    cpu 28
    gpu 31
    rom 19
  ]
  node [
    id 14
    label "14"
    cpu 4
    gpu 37
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
  edge [
    source 9
    target 10
    bw 10
  ]
  edge [
    source 10
    target 11
    bw 7
  ]
  edge [
    source 11
    target 12
    bw 39
  ]
  edge [
    source 12
    target 13
    bw 13
  ]
  edge [
    source 13
    target 14
    bw 43
  ]
]
