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
  id 4
  arrival_time 74.15141257366842
  lifetime 2083.0322725070655
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 27
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 16
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 15
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 42
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 39
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 23
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 24
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 49
    rom 17
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 41
    rom 37
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 9
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 43
    gpu 2
    rom 6
  ]
  node [
    id 11
    label "11"
    cpu 36
    gpu 26
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 48
    gpu 23
    rom 20
  ]
  node [
    id 13
    label "13"
    cpu 47
    gpu 13
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 45
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
  edge [
    source 10
    target 11
    bw 4
  ]
  edge [
    source 11
    target 12
    bw 17
  ]
  edge [
    source 12
    target 13
    bw 21
  ]
]
