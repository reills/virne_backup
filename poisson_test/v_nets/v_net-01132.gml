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
  id 1132
  arrival_time 23554.424623395073
  lifetime 2920.636657616535
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 11
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 42
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 18
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 5
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 31
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 39
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 28
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 41
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 3
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 29
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 13
    rom 8
  ]
  node [
    id 11
    label "11"
    cpu 32
    gpu 34
    rom 7
  ]
  node [
    id 12
    label "12"
    cpu 45
    gpu 15
    rom 10
  ]
  node [
    id 13
    label "13"
    cpu 2
    gpu 14
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 41
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
  edge [
    source 9
    target 10
    bw 26
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
  edge [
    source 11
    target 12
    bw 23
  ]
  edge [
    source 12
    target 13
    bw 42
  ]
]
