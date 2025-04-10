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
  id 620
  arrival_time 12814.363752240013
  lifetime 1083.1472031169499
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 38
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 21
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 33
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 9
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 45
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 29
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 18
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 33
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 31
    gpu 7
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 41
    gpu 35
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 45
    gpu 12
    rom 21
  ]
  node [
    id 11
    label "11"
    cpu 30
    gpu 3
    rom 50
  ]
  node [
    id 12
    label "12"
    cpu 28
    gpu 5
    rom 13
  ]
  node [
    id 13
    label "13"
    cpu 24
    gpu 28
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
  edge [
    source 9
    target 10
    bw 5
  ]
  edge [
    source 10
    target 11
    bw 34
  ]
  edge [
    source 11
    target 12
    bw 6
  ]
  edge [
    source 12
    target 13
    bw 16
  ]
]
