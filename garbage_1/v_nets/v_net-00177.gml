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
  id 177
  arrival_time 3301.7400721699196
  lifetime 601.7538463359115
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 31
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 17
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 49
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 6
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 22
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 14
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 47
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 30
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 9
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 44
    gpu 34
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 39
    gpu 30
    rom 14
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 16
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 36
    gpu 30
    rom 18
  ]
  node [
    id 13
    label "13"
    cpu 36
    gpu 8
    rom 35
  ]
  node [
    id 14
    label "14"
    cpu 12
    gpu 0
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 15
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
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 21
  ]
  edge [
    source 12
    target 13
    bw 13
  ]
  edge [
    source 13
    target 14
    bw 18
  ]
]
