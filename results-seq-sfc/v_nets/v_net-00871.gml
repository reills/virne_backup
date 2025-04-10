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
  id 871
  arrival_time 18124.381845632743
  lifetime 3012.321245954387
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 42
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 37
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 9
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 25
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 20
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 15
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 24
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 41
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 42
    rom 45
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 36
    rom 36
  ]
  node [
    id 10
    label "10"
    cpu 42
    gpu 36
    rom 6
  ]
  node [
    id 11
    label "11"
    cpu 36
    gpu 38
    rom 28
  ]
  node [
    id 12
    label "12"
    cpu 23
    gpu 20
    rom 21
  ]
  node [
    id 13
    label "13"
    cpu 35
    gpu 12
    rom 20
  ]
  node [
    id 14
    label "14"
    cpu 9
    gpu 12
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 41
  ]
  edge [
    source 8
    target 9
    bw 36
  ]
  edge [
    source 9
    target 10
    bw 5
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
  edge [
    source 11
    target 12
    bw 45
  ]
  edge [
    source 12
    target 13
    bw 22
  ]
  edge [
    source 13
    target 14
    bw 26
  ]
]
