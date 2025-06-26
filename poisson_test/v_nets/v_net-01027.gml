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
  id 1027
  arrival_time 21845.80563834472
  lifetime 377.78654606459077
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 10
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 9
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 21
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 16
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 3
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 28
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 11
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 30
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 28
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 1
    gpu 50
    rom 31
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 7
    rom 46
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 46
    rom 21
  ]
  node [
    id 12
    label "12"
    cpu 31
    gpu 41
    rom 27
  ]
  node [
    id 13
    label "13"
    cpu 4
    gpu 3
    rom 1
  ]
  node [
    id 14
    label "14"
    cpu 47
    gpu 13
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 40
  ]
  edge [
    source 8
    target 9
    bw 23
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
  edge [
    source 10
    target 11
    bw 26
  ]
  edge [
    source 11
    target 12
    bw 40
  ]
  edge [
    source 12
    target 13
    bw 33
  ]
  edge [
    source 13
    target 14
    bw 0
  ]
]
