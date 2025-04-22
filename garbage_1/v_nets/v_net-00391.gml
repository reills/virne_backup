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
  id 391
  arrival_time 7809.879249809912
  lifetime 1533.5948177244638
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 15
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 22
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 48
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 12
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 11
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 23
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 42
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 14
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 7
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 32
    rom 16
  ]
  node [
    id 10
    label "10"
    cpu 19
    gpu 40
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
]
