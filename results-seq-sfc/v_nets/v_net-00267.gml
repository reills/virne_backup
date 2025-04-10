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
  id 267
  arrival_time 5222.0505263559635
  lifetime 432.5813321116552
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 4
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 21
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 46
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 37
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 42
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 27
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 3
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 32
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 11
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 13
    gpu 16
    rom 25
  ]
  node [
    id 10
    label "10"
    cpu 20
    gpu 17
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 42
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
]
