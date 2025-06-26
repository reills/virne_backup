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
  id 1495
  arrival_time 33248.22395892339
  lifetime 149.50086779619573
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 27
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 48
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 1
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 15
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 14
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 17
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 40
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 38
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 13
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 42
    gpu 13
    rom 42
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 14
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 37
    gpu 50
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 1
  ]
  edge [
    source 9
    target 10
    bw 32
  ]
  edge [
    source 10
    target 11
    bw 17
  ]
]
