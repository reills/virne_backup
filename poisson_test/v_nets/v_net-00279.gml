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
  id 279
  arrival_time 5375.891369123067
  lifetime 1692.9268806342357
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 39
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 7
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 23
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 23
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 10
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 8
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 40
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 35
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
]
