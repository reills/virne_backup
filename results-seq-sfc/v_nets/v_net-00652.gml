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
  id 652
  arrival_time 13829.201426313355
  lifetime 988.0971431282579
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 36
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 25
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 39
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 49
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 40
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 45
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 42
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 27
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 43
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 0
    gpu 12
    rom 31
  ]
  node [
    id 10
    label "10"
    cpu 4
    gpu 34
    rom 38
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 25
    rom 32
  ]
  node [
    id 12
    label "12"
    cpu 42
    gpu 10
    rom 18
  ]
  node [
    id 13
    label "13"
    cpu 36
    gpu 1
    rom 1
  ]
  node [
    id 14
    label "14"
    cpu 28
    gpu 18
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
  edge [
    source 11
    target 12
    bw 44
  ]
  edge [
    source 12
    target 13
    bw 3
  ]
  edge [
    source 13
    target 14
    bw 31
  ]
]
