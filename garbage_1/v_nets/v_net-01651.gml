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
  id 1651
  arrival_time 36858.65098207687
  lifetime 380.90359754130094
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 39
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 44
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 18
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 8
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 0
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 36
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 28
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 14
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 22
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 34
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 28
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
]
