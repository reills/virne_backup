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
  id 1785
  arrival_time 39762.922168713296
  lifetime 1014.2755253364379
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 43
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 22
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 20
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 7
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 40
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 40
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 25
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 43
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 15
    rom 7
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 5
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 18
    gpu 30
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 20
  ]
  edge [
    source 9
    target 10
    bw 0
  ]
]
