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
  id 1452
  arrival_time 30599.991656814527
  lifetime 592.5127283645589
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 22
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 31
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 19
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 30
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 30
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 1
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 40
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 26
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 35
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 12
    rom 33
  ]
  node [
    id 10
    label "10"
    cpu 6
    gpu 0
    rom 29
  ]
  node [
    id 11
    label "11"
    cpu 44
    gpu 30
    rom 17
  ]
  node [
    id 12
    label "12"
    cpu 15
    gpu 18
    rom 33
  ]
  node [
    id 13
    label "13"
    cpu 14
    gpu 45
    rom 18
  ]
  node [
    id 14
    label "14"
    cpu 16
    gpu 19
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
  edge [
    source 11
    target 12
    bw 7
  ]
  edge [
    source 12
    target 13
    bw 50
  ]
  edge [
    source 13
    target 14
    bw 9
  ]
]
