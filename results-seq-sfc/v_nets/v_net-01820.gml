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
  id 1820
  arrival_time 40292.02341241848
  lifetime 1710.1269764684182
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 26
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 8
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 8
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 6
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 9
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 49
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 50
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 39
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 31
    gpu 0
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 45
    rom 37
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 31
    rom 47
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 4
    rom 11
  ]
  node [
    id 12
    label "12"
    cpu 19
    gpu 40
    rom 0
  ]
  node [
    id 13
    label "13"
    cpu 21
    gpu 35
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 12
  ]
  edge [
    source 11
    target 12
    bw 8
  ]
  edge [
    source 12
    target 13
    bw 42
  ]
]
