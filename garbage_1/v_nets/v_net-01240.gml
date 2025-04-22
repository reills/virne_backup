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
  id 1240
  arrival_time 25564.610832790717
  lifetime 105.3580537221975
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 14
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 0
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 39
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 23
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 36
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 34
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 47
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 30
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 40
    rom 16
  ]
  node [
    id 9
    label "9"
    cpu 9
    gpu 34
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 5
    gpu 4
    rom 18
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 36
    rom 6
  ]
  node [
    id 12
    label "12"
    cpu 19
    gpu 50
    rom 12
  ]
  node [
    id 13
    label "13"
    cpu 32
    gpu 40
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 20
  ]
  edge [
    source 9
    target 10
    bw 10
  ]
  edge [
    source 10
    target 11
    bw 31
  ]
  edge [
    source 11
    target 12
    bw 45
  ]
  edge [
    source 12
    target 13
    bw 1
  ]
]
