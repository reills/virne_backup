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
  id 1058
  arrival_time 22324.208577123874
  lifetime 406.6688832630869
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 38
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 40
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 37
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 39
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 6
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 26
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 5
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 34
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 36
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 32
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 1
    rom 16
  ]
  node [
    id 11
    label "11"
    cpu 36
    gpu 39
    rom 12
  ]
  node [
    id 12
    label "12"
    cpu 43
    gpu 24
    rom 42
  ]
  node [
    id 13
    label "13"
    cpu 6
    gpu 30
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 46
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
    bw 31
  ]
]
