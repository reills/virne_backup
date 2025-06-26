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
  id 427
  arrival_time 8366.80690729688
  lifetime 291.1801956274711
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 48
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 7
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 17
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 12
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 38
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 9
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 3
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 27
    rom 2
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 44
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 13
    gpu 12
    rom 18
  ]
  node [
    id 10
    label "10"
    cpu 46
    gpu 34
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 38
  ]
  edge [
    source 9
    target 10
    bw 11
  ]
]
