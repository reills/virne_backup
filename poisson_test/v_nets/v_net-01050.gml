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
  id 1050
  arrival_time 22140.844263733055
  lifetime 801.8030901122015
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 24
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 33
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 46
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 1
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 12
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 45
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 37
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 50
    gpu 16
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 16
    rom 6
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 29
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 11
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 15
    rom 34
  ]
  node [
    id 12
    label "12"
    cpu 2
    gpu 39
    rom 1
  ]
  node [
    id 13
    label "13"
    cpu 15
    gpu 30
    rom 28
  ]
  node [
    id 14
    label "14"
    cpu 23
    gpu 7
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 6
  ]
  edge [
    source 11
    target 12
    bw 33
  ]
  edge [
    source 12
    target 13
    bw 27
  ]
  edge [
    source 13
    target 14
    bw 41
  ]
]
