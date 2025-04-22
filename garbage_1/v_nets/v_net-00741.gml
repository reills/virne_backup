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
  id 741
  arrival_time 15537.704345327827
  lifetime 836.0079178807594
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 14
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 27
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 20
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 20
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 15
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 9
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 8
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 0
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 17
    rom 23
  ]
  node [
    id 9
    label "9"
    cpu 2
    gpu 36
    rom 47
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 12
    rom 26
  ]
  node [
    id 11
    label "11"
    cpu 14
    gpu 46
    rom 6
  ]
  node [
    id 12
    label "12"
    cpu 9
    gpu 28
    rom 35
  ]
  node [
    id 13
    label "13"
    cpu 48
    gpu 10
    rom 36
  ]
  node [
    id 14
    label "14"
    cpu 10
    gpu 45
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 8
  ]
  edge [
    source 11
    target 12
    bw 40
  ]
  edge [
    source 12
    target 13
    bw 9
  ]
  edge [
    source 13
    target 14
    bw 30
  ]
]
