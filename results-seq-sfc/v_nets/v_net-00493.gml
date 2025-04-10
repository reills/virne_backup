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
  id 493
  arrival_time 9256.39366182199
  lifetime 12.15278781607058
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 48
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 30
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 42
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 46
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 10
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 29
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 15
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 7
    rom 38
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 14
    rom 2
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 20
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 21
    gpu 28
    rom 3
  ]
  node [
    id 11
    label "11"
    cpu 9
    gpu 5
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 40
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
]
