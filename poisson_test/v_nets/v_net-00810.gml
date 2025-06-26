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
  id 810
  arrival_time 16804.320560047414
  lifetime 380.75429617556017
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 2
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 31
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 4
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 9
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 11
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 35
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 25
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 9
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
]
