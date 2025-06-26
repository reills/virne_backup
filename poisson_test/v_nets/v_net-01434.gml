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
  id 1434
  arrival_time 30154.62707469417
  lifetime 314.5884233769618
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 40
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 45
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 7
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 50
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 50
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 17
    gpu 36
    rom 24
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 31
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 3
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 29
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 46
    rom 28
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 12
    rom 19
  ]
  node [
    id 11
    label "11"
    cpu 17
    gpu 28
    rom 18
  ]
  node [
    id 12
    label "12"
    cpu 47
    gpu 32
    rom 19
  ]
  node [
    id 13
    label "13"
    cpu 13
    gpu 24
    rom 37
  ]
  node [
    id 14
    label "14"
    cpu 1
    gpu 23
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 46
  ]
  edge [
    source 11
    target 12
    bw 43
  ]
  edge [
    source 12
    target 13
    bw 40
  ]
  edge [
    source 13
    target 14
    bw 34
  ]
]
