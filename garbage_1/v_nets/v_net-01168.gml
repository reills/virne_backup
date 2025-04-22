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
  id 1168
  arrival_time 24209.563758753877
  lifetime 736.7621197089125
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 40
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 14
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 9
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 30
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 5
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 14
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 11
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 24
    gpu 22
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 0
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 40
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 36
    rom 15
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 26
    rom 0
  ]
  node [
    id 12
    label "12"
    cpu 26
    gpu 1
    rom 17
  ]
  node [
    id 13
    label "13"
    cpu 3
    gpu 27
    rom 37
  ]
  node [
    id 14
    label "14"
    cpu 47
    gpu 7
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
  edge [
    source 9
    target 10
    bw 22
  ]
  edge [
    source 10
    target 11
    bw 42
  ]
  edge [
    source 11
    target 12
    bw 26
  ]
  edge [
    source 12
    target 13
    bw 43
  ]
  edge [
    source 13
    target 14
    bw 15
  ]
]
