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
  id 562
  arrival_time 10545.12936944985
  lifetime 80.59582692972283
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 9
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 26
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 19
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 0
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 22
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 0
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 33
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 40
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 21
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 36
    gpu 34
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 4
    gpu 42
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 27
    gpu 4
    rom 32
  ]
  node [
    id 12
    label "12"
    cpu 8
    gpu 24
    rom 27
  ]
  node [
    id 13
    label "13"
    cpu 19
    gpu 4
    rom 13
  ]
  node [
    id 14
    label "14"
    cpu 42
    gpu 50
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 42
  ]
  edge [
    source 10
    target 11
    bw 40
  ]
  edge [
    source 11
    target 12
    bw 37
  ]
  edge [
    source 12
    target 13
    bw 29
  ]
  edge [
    source 13
    target 14
    bw 21
  ]
]
