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
  id 299
  arrival_time 5755.451393076217
  lifetime 1848.2176177958506
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 1
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 42
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 45
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 38
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 32
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 8
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 39
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 3
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 40
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 40
  ]
]
