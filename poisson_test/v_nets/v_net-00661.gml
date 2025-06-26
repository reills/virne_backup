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
  id 661
  arrival_time 14129.481562766641
  lifetime 64.5593330044014
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 1
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 16
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 18
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 3
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 37
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 38
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 1
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 22
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 27
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
]
