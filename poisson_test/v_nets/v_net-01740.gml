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
  id 1740
  arrival_time 38919.453227196325
  lifetime 1461.461684084395
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 17
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 30
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 32
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 27
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 0
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 45
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 34
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 20
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 2
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 48
    rom 13
  ]
  node [
    id 10
    label "10"
    cpu 48
    gpu 44
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 12
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
  edge [
    source 9
    target 10
    bw 40
  ]
]
