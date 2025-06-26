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
  id 1573
  arrival_time 35117.502138684176
  lifetime 1570.3525199022451
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 4
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 28
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 49
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 45
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 33
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 43
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 28
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 4
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 24
    rom 45
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 2
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 6
    rom 35
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 4
    rom 48
  ]
  node [
    id 12
    label "12"
    cpu 32
    gpu 49
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 40
  ]
  edge [
    source 8
    target 9
    bw 38
  ]
  edge [
    source 9
    target 10
    bw 1
  ]
  edge [
    source 10
    target 11
    bw 36
  ]
  edge [
    source 11
    target 12
    bw 46
  ]
]
