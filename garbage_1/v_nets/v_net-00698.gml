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
  id 698
  arrival_time 14749.181994889728
  lifetime 89.97852835297898
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 42
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 21
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 46
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 46
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 35
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 4
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 6
    rom 32
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 10
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 3
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 46
    rom 33
  ]
  node [
    id 10
    label "10"
    cpu 42
    gpu 46
    rom 41
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 34
    rom 48
  ]
  node [
    id 12
    label "12"
    cpu 0
    gpu 42
    rom 24
  ]
  node [
    id 13
    label "13"
    cpu 18
    gpu 4
    rom 6
  ]
  node [
    id 14
    label "14"
    cpu 49
    gpu 32
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 10
  ]
  edge [
    source 11
    target 12
    bw 16
  ]
  edge [
    source 12
    target 13
    bw 13
  ]
  edge [
    source 13
    target 14
    bw 39
  ]
]
