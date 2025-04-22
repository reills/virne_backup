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
  id 1085
  arrival_time 22639.489409538488
  lifetime 671.6873962417594
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 36
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 23
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 39
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 27
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 8
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 21
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 8
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 6
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 6
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 26
    rom 50
  ]
  node [
    id 10
    label "10"
    cpu 41
    gpu 20
    rom 50
  ]
  node [
    id 11
    label "11"
    cpu 13
    gpu 8
    rom 3
  ]
  node [
    id 12
    label "12"
    cpu 4
    gpu 38
    rom 11
  ]
  node [
    id 13
    label "13"
    cpu 10
    gpu 39
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 0
  ]
  edge [
    source 11
    target 12
    bw 21
  ]
  edge [
    source 12
    target 13
    bw 49
  ]
]
