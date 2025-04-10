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
  id 330
  arrival_time 6324.364114624626
  lifetime 1922.8112607614116
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 19
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 15
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 32
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 20
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 47
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 29
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 16
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 11
    rom 3
  ]
  node [
    id 8
    label "8"
    cpu 30
    gpu 13
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 48
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 9
    gpu 10
    rom 50
  ]
  node [
    id 11
    label "11"
    cpu 24
    gpu 21
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 12
  ]
  edge [
    source 7
    target 8
    bw 34
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
  edge [
    source 9
    target 10
    bw 22
  ]
  edge [
    source 10
    target 11
    bw 31
  ]
]
