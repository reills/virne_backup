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
  id 328
  arrival_time 6318.55670725044
  lifetime 325.36186772652775
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 41
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 17
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 12
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 13
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 21
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 25
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 37
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 17
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 28
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 43
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 16
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 6
  ]
]
