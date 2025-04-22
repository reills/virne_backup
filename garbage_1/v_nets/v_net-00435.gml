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
  id 435
  arrival_time 8421.10803608959
  lifetime 1150.3717724135713
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 47
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 7
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 49
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 1
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 11
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 7
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 28
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 2
    rom 38
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 20
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 37
    rom 50
  ]
  node [
    id 10
    label "10"
    cpu 44
    gpu 48
    rom 16
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 26
    rom 14
  ]
  node [
    id 12
    label "12"
    cpu 16
    gpu 27
    rom 19
  ]
  node [
    id 13
    label "13"
    cpu 13
    gpu 31
    rom 47
  ]
  node [
    id 14
    label "14"
    cpu 5
    gpu 11
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 21
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
    bw 41
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 42
  ]
  edge [
    source 10
    target 11
    bw 39
  ]
  edge [
    source 11
    target 12
    bw 40
  ]
  edge [
    source 12
    target 13
    bw 44
  ]
  edge [
    source 13
    target 14
    bw 39
  ]
]
