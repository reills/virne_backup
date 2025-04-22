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
  id 469
  arrival_time 8813.64122179209
  lifetime 595.7900862973278
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 39
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 49
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 9
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 0
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 9
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 40
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 49
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 2
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 30
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 16
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 43
    rom 22
  ]
  node [
    id 11
    label "11"
    cpu 32
    gpu 6
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 12
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 3
  ]
  edge [
    source 10
    target 11
    bw 21
  ]
]
