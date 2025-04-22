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
  id 1301
  arrival_time 27127.161744382076
  lifetime 270.6819863595521
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 47
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 50
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 48
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 25
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 19
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 19
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 46
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 24
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 27
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 26
    gpu 33
    rom 4
  ]
  node [
    id 10
    label "10"
    cpu 46
    gpu 34
    rom 41
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
    cpu 12
    gpu 9
    rom 27
  ]
  node [
    id 13
    label "13"
    cpu 43
    gpu 9
    rom 21
  ]
  node [
    id 14
    label "14"
    cpu 22
    gpu 35
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 48
  ]
  edge [
    source 9
    target 10
    bw 17
  ]
  edge [
    source 10
    target 11
    bw 35
  ]
  edge [
    source 11
    target 12
    bw 8
  ]
  edge [
    source 12
    target 13
    bw 16
  ]
  edge [
    source 13
    target 14
    bw 34
  ]
]
