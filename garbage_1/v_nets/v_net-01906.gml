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
  id 1906
  arrival_time 41989.7707585653
  lifetime 2113.248259220766
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 2
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 28
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 47
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 5
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 35
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 18
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 2
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 3
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 14
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 25
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 38
    rom 38
  ]
  node [
    id 11
    label "11"
    cpu 17
    gpu 2
    rom 18
  ]
  node [
    id 12
    label "12"
    cpu 5
    gpu 39
    rom 21
  ]
  node [
    id 13
    label "13"
    cpu 29
    gpu 22
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
  edge [
    source 11
    target 12
    bw 16
  ]
  edge [
    source 12
    target 13
    bw 45
  ]
]
