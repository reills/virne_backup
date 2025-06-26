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
  id 1524
  arrival_time 33804.48538398605
  lifetime 474.59389288741477
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 9
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 42
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 47
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 15
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 20
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 50
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 44
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 15
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 7
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 21
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
]
