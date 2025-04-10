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
  id 492
  arrival_time 9249.369817583405
  lifetime 55.140302857684446
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 16
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 24
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 18
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 6
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 0
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 3
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 46
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 39
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 42
  ]
]
