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
  id 1746
  arrival_time 38943.966837426386
  lifetime 3987.1873578931572
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 4
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 14
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 5
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 25
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 30
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 36
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 36
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 14
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 0
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 41
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 42
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
]
