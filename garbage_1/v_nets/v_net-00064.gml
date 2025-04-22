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
  id 64
  arrival_time 1265.4659648909417
  lifetime 733.5639278242277
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 27
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 47
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 32
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 40
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 18
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 32
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 49
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 22
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 43
    gpu 46
    rom 26
  ]
  node [
    id 9
    label "9"
    cpu 2
    gpu 4
    rom 38
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 1
    rom 50
  ]
  node [
    id 11
    label "11"
    cpu 31
    gpu 32
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
  edge [
    source 9
    target 10
    bw 22
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
]
