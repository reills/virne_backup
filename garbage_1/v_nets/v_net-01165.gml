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
  id 1165
  arrival_time 24164.3875793398
  lifetime 1995.3066320319922
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 33
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 4
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 12
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 33
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 23
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 4
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 16
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 0
    rom 21
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 40
    rom 8
  ]
  node [
    id 9
    label "9"
    cpu 42
    gpu 42
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 9
    gpu 11
    rom 23
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 12
    rom 45
  ]
  node [
    id 12
    label "12"
    cpu 8
    gpu 20
    rom 32
  ]
  node [
    id 13
    label "13"
    cpu 27
    gpu 34
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 38
  ]
  edge [
    source 9
    target 10
    bw 23
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
  edge [
    source 11
    target 12
    bw 0
  ]
  edge [
    source 12
    target 13
    bw 31
  ]
]
