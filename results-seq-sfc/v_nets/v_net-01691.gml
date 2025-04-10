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
  id 1691
  arrival_time 37620.38280050116
  lifetime 2015.730715075763
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 1
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 25
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 46
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 5
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 44
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 9
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 29
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 10
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 49
    rom 6
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 12
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 42
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 7
    gpu 37
    rom 21
  ]
  node [
    id 12
    label "12"
    cpu 25
    gpu 43
    rom 1
  ]
  node [
    id 13
    label "13"
    cpu 6
    gpu 3
    rom 4
  ]
  node [
    id 14
    label "14"
    cpu 41
    gpu 4
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 43
  ]
  edge [
    source 11
    target 12
    bw 5
  ]
  edge [
    source 12
    target 13
    bw 20
  ]
  edge [
    source 13
    target 14
    bw 29
  ]
]
