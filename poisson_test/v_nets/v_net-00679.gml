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
  id 679
  arrival_time 14382.311286454997
  lifetime 2002.174751115915
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 36
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 20
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 14
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 14
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 26
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 23
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 44
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 0
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 33
    gpu 30
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 2
    gpu 42
    rom 13
  ]
  node [
    id 10
    label "10"
    cpu 34
    gpu 30
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
]
