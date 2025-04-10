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
  id 1656
  arrival_time 37028.25725195326
  lifetime 36.1269557692557
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 40
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 22
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 10
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 42
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 35
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 7
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 15
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 6
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 25
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 36
    gpu 48
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 42
    gpu 18
    rom 30
  ]
  node [
    id 11
    label "11"
    cpu 13
    gpu 17
    rom 12
  ]
  node [
    id 12
    label "12"
    cpu 48
    gpu 37
    rom 21
  ]
  node [
    id 13
    label "13"
    cpu 22
    gpu 17
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 41
  ]
  edge [
    source 8
    target 9
    bw 48
  ]
  edge [
    source 9
    target 10
    bw 0
  ]
  edge [
    source 10
    target 11
    bw 47
  ]
  edge [
    source 11
    target 12
    bw 16
  ]
  edge [
    source 12
    target 13
    bw 14
  ]
]
