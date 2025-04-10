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
  id 658
  arrival_time 13913.17713616607
  lifetime 4129.898959886655
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 6
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 10
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 5
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 30
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 39
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 38
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 45
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 33
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 26
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 12
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 11
    gpu 28
    rom 26
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 48
    rom 36
  ]
  node [
    id 12
    label "12"
    cpu 3
    gpu 34
    rom 17
  ]
  node [
    id 13
    label "13"
    cpu 0
    gpu 43
    rom 28
  ]
  node [
    id 14
    label "14"
    cpu 6
    gpu 44
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
  edge [
    source 9
    target 10
    bw 38
  ]
  edge [
    source 10
    target 11
    bw 9
  ]
  edge [
    source 11
    target 12
    bw 2
  ]
  edge [
    source 12
    target 13
    bw 19
  ]
  edge [
    source 13
    target 14
    bw 18
  ]
]
