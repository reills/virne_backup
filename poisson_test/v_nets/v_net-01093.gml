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
  id 1093
  arrival_time 22823.93639168088
  lifetime 1267.1210930505924
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 35
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 45
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 44
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 48
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 26
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 21
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 29
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 8
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 32
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 10
    gpu 33
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 49
    rom 2
  ]
  node [
    id 11
    label "11"
    cpu 9
    gpu 24
    rom 26
  ]
  node [
    id 12
    label "12"
    cpu 50
    gpu 46
    rom 29
  ]
  node [
    id 13
    label "13"
    cpu 42
    gpu 0
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 34
  ]
  edge [
    source 11
    target 12
    bw 3
  ]
  edge [
    source 12
    target 13
    bw 16
  ]
]
