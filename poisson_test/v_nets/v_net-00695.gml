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
  id 695
  arrival_time 14687.179709305592
  lifetime 114.12221038699275
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 48
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 22
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 38
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 49
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 7
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 4
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 3
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 13
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 5
    rom 31
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 44
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 30
    rom 32
  ]
  node [
    id 11
    label "11"
    cpu 39
    gpu 29
    rom 47
  ]
  node [
    id 12
    label "12"
    cpu 40
    gpu 34
    rom 5
  ]
  node [
    id 13
    label "13"
    cpu 5
    gpu 3
    rom 21
  ]
  node [
    id 14
    label "14"
    cpu 18
    gpu 16
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 15
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 34
  ]
  edge [
    source 11
    target 12
    bw 38
  ]
  edge [
    source 12
    target 13
    bw 28
  ]
  edge [
    source 13
    target 14
    bw 22
  ]
]
