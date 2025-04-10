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
  id 1140
  arrival_time 23851.481758038448
  lifetime 2415.0759650879413
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 7
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 42
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 6
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 41
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 40
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 6
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 34
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 26
    rom 26
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 33
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 18
    gpu 41
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 21
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 27
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 15
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
]
