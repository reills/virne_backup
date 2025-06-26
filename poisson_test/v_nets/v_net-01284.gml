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
  id 1284
  arrival_time 26767.7664518231
  lifetime 351.0183442455309
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 8
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 28
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 29
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 15
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 8
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 37
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 1
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 27
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 40
    rom 31
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 38
    rom 1
  ]
  node [
    id 10
    label "10"
    cpu 37
    gpu 0
    rom 20
  ]
  node [
    id 11
    label "11"
    cpu 41
    gpu 36
    rom 32
  ]
  node [
    id 12
    label "12"
    cpu 28
    gpu 28
    rom 37
  ]
  node [
    id 13
    label "13"
    cpu 19
    gpu 38
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 28
  ]
  edge [
    source 11
    target 12
    bw 13
  ]
  edge [
    source 12
    target 13
    bw 11
  ]
]
