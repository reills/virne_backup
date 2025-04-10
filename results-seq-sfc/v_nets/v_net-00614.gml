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
  id 614
  arrival_time 12774.35594781638
  lifetime 4464.628941591267
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 1
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 22
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 8
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 28
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 30
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 41
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 34
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 31
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 38
    rom 48
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 42
    rom 3
  ]
  node [
    id 10
    label "10"
    cpu 20
    gpu 16
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
]
