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
  id 1560
  arrival_time 34934.502347206624
  lifetime 1759.7716456889195
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 22
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 11
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 19
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 23
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 31
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 4
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 19
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 40
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 16
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 40
    rom 50
  ]
  node [
    id 10
    label "10"
    cpu 6
    gpu 27
    rom 2
  ]
  node [
    id 11
    label "11"
    cpu 35
    gpu 28
    rom 30
  ]
  node [
    id 12
    label "12"
    cpu 12
    gpu 26
    rom 24
  ]
  node [
    id 13
    label "13"
    cpu 17
    gpu 45
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 26
  ]
  edge [
    source 11
    target 12
    bw 41
  ]
  edge [
    source 12
    target 13
    bw 22
  ]
]
