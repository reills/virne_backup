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
  id 440
  arrival_time 8462.476653049647
  lifetime 2078.773431556427
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 10
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 19
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 48
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 18
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 1
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 37
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 26
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 50
    gpu 21
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 23
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 21
    gpu 33
    rom 25
  ]
  node [
    id 10
    label "10"
    cpu 0
    gpu 35
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 42
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
]
