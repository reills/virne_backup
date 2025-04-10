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
  id 722
  arrival_time 15272.585358652712
  lifetime 787.1301496350603
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 24
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 19
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 14
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 39
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 41
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 19
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 7
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 28
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 28
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 42
    rom 33
  ]
  node [
    id 10
    label "10"
    cpu 5
    gpu 16
    rom 3
  ]
  node [
    id 11
    label "11"
    cpu 31
    gpu 44
    rom 10
  ]
  node [
    id 12
    label "12"
    cpu 45
    gpu 47
    rom 38
  ]
  node [
    id 13
    label "13"
    cpu 3
    gpu 49
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
  edge [
    source 10
    target 11
    bw 12
  ]
  edge [
    source 11
    target 12
    bw 16
  ]
  edge [
    source 12
    target 13
    bw 25
  ]
]
