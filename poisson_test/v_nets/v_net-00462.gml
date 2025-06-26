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
  id 462
  arrival_time 8738.258379734354
  lifetime 139.6084107057333
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 6
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 0
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 13
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 37
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 17
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 39
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 8
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 21
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 37
    rom 28
  ]
  node [
    id 9
    label "9"
    cpu 1
    gpu 0
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 16
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
]
