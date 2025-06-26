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
  id 1951
  arrival_time 42831.34479240729
  lifetime 544.0098157988098
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 43
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 11
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 21
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 35
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 17
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 49
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 21
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 36
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 47
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 41
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 16
    gpu 12
    rom 20
  ]
  node [
    id 11
    label "11"
    cpu 14
    gpu 32
    rom 8
  ]
  node [
    id 12
    label "12"
    cpu 13
    gpu 16
    rom 49
  ]
  node [
    id 13
    label "13"
    cpu 22
    gpu 14
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 40
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
  edge [
    source 9
    target 10
    bw 50
  ]
  edge [
    source 10
    target 11
    bw 43
  ]
  edge [
    source 11
    target 12
    bw 42
  ]
  edge [
    source 12
    target 13
    bw 8
  ]
]
