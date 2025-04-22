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
  id 1223
  arrival_time 25378.360273966773
  lifetime 671.5779028177986
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 45
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 50
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 19
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 22
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 0
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 33
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 13
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 30
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 37
    rom 39
  ]
  node [
    id 9
    label "9"
    cpu 46
    gpu 0
    rom 39
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 26
    rom 14
  ]
  node [
    id 11
    label "11"
    cpu 5
    gpu 29
    rom 4
  ]
  node [
    id 12
    label "12"
    cpu 28
    gpu 14
    rom 6
  ]
  node [
    id 13
    label "13"
    cpu 6
    gpu 8
    rom 49
  ]
  node [
    id 14
    label "14"
    cpu 45
    gpu 7
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
  edge [
    source 10
    target 11
    bw 35
  ]
  edge [
    source 11
    target 12
    bw 8
  ]
  edge [
    source 12
    target 13
    bw 30
  ]
  edge [
    source 13
    target 14
    bw 44
  ]
]
