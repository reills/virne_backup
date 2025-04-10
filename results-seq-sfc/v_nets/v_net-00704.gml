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
  id 704
  arrival_time 14818.667234043673
  lifetime 1075.0952819466436
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 0
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 14
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 39
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 16
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 50
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 45
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 26
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 43
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 34
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 2
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 32
  ]
]
