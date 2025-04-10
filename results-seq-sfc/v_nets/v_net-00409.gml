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
  id 409
  arrival_time 8041.0039389436315
  lifetime 50.182758894444156
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 45
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 34
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 41
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 21
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 15
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 18
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 16
    gpu 14
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 21
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 15
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 0
    gpu 47
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 14
    gpu 3
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 34
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
  edge [
    source 9
    target 10
    bw 32
  ]
]
