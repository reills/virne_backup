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
  id 482
  arrival_time 8931.133114122053
  lifetime 1503.2023768889012
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 33
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 37
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 30
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 45
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 27
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 45
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 38
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 30
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 32
    rom 48
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 10
    rom 27
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 46
    rom 24
  ]
  node [
    id 11
    label "11"
    cpu 15
    gpu 10
    rom 23
  ]
  node [
    id 12
    label "12"
    cpu 36
    gpu 12
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 31
  ]
  edge [
    source 10
    target 11
    bw 13
  ]
  edge [
    source 11
    target 12
    bw 3
  ]
]
