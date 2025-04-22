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
  id 1997
  arrival_time 43518.28909074272
  lifetime 265.50951951339187
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 28
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 40
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 34
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 38
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 9
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 12
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 27
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 8
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 48
    rom 31
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 37
    rom 1
  ]
  node [
    id 10
    label "10"
    cpu 23
    gpu 1
    rom 20
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 18
    rom 23
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 13
    rom 0
  ]
  node [
    id 13
    label "13"
    cpu 38
    gpu 35
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
  edge [
    source 9
    target 10
    bw 24
  ]
  edge [
    source 10
    target 11
    bw 42
  ]
  edge [
    source 11
    target 12
    bw 29
  ]
  edge [
    source 12
    target 13
    bw 19
  ]
]
