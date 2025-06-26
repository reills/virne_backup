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
  id 663
  arrival_time 14142.340197937609
  lifetime 559.6142700034522
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 10
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 36
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 28
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 29
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 16
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 17
    rom 24
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 0
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 21
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 21
    rom 41
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 28
    rom 50
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 7
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 8
    gpu 35
    rom 9
  ]
  node [
    id 12
    label "12"
    cpu 22
    gpu 6
    rom 14
  ]
  node [
    id 13
    label "13"
    cpu 2
    gpu 48
    rom 29
  ]
  node [
    id 14
    label "14"
    cpu 23
    gpu 47
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 6
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 24
  ]
  edge [
    source 12
    target 13
    bw 19
  ]
  edge [
    source 13
    target 14
    bw 0
  ]
]
