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
  id 808
  arrival_time 16787.99116916372
  lifetime 205.8403470729885
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 34
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 23
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 0
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 11
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 43
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 37
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 16
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 0
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 30
    gpu 35
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 12
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 12
    rom 20
  ]
  node [
    id 11
    label "11"
    cpu 18
    gpu 14
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 9
    gpu 8
    rom 7
  ]
  node [
    id 13
    label "13"
    cpu 18
    gpu 34
    rom 12
  ]
  node [
    id 14
    label "14"
    cpu 48
    gpu 48
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 42
  ]
  edge [
    source 8
    target 9
    bw 1
  ]
  edge [
    source 9
    target 10
    bw 42
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
  edge [
    source 11
    target 12
    bw 38
  ]
  edge [
    source 12
    target 13
    bw 38
  ]
  edge [
    source 13
    target 14
    bw 42
  ]
]
