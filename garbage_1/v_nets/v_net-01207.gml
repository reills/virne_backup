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
  id 1207
  arrival_time 25120.48456879919
  lifetime 1166.601629830526
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 23
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 39
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 13
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 12
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 38
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 29
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 48
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 21
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 6
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 13
    rom 41
  ]
  node [
    id 10
    label "10"
    cpu 18
    gpu 24
    rom 18
  ]
  node [
    id 11
    label "11"
    cpu 13
    gpu 35
    rom 17
  ]
  node [
    id 12
    label "12"
    cpu 19
    gpu 13
    rom 41
  ]
  node [
    id 13
    label "13"
    cpu 41
    gpu 10
    rom 17
  ]
  node [
    id 14
    label "14"
    cpu 24
    gpu 29
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
  edge [
    source 9
    target 10
    bw 0
  ]
  edge [
    source 10
    target 11
    bw 21
  ]
  edge [
    source 11
    target 12
    bw 46
  ]
  edge [
    source 12
    target 13
    bw 30
  ]
  edge [
    source 13
    target 14
    bw 37
  ]
]
