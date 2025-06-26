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
  id 1569
  arrival_time 35023.266130504744
  lifetime 2815.04689389591
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 46
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 46
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 37
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 15
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 12
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 44
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 48
    rom 0
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 47
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 43
    rom 47
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 33
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 36
    gpu 12
    rom 20
  ]
  node [
    id 11
    label "11"
    cpu 49
    gpu 17
    rom 33
  ]
  node [
    id 12
    label "12"
    cpu 34
    gpu 6
    rom 24
  ]
  node [
    id 13
    label "13"
    cpu 18
    gpu 17
    rom 35
  ]
  node [
    id 14
    label "14"
    cpu 8
    gpu 37
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
  edge [
    source 9
    target 10
    bw 38
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
  edge [
    source 11
    target 12
    bw 3
  ]
  edge [
    source 12
    target 13
    bw 42
  ]
  edge [
    source 13
    target 14
    bw 43
  ]
]
