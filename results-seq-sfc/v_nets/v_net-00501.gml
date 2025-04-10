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
  id 501
  arrival_time 9447.368036091819
  lifetime 1029.4025280492122
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 28
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 3
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 9
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 31
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 6
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 28
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 37
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 14
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 41
    gpu 0
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 9
    gpu 13
    rom 10
  ]
  node [
    id 10
    label "10"
    cpu 2
    gpu 37
    rom 15
  ]
  node [
    id 11
    label "11"
    cpu 34
    gpu 19
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 13
  ]
  edge [
    source 10
    target 11
    bw 48
  ]
]
