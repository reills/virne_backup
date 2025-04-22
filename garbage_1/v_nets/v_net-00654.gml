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
  id 654
  arrival_time 13837.693627569266
  lifetime 556.9753544815978
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 1
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 26
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 15
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 3
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 17
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 27
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 0
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 14
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 3
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 50
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 21
    rom 4
  ]
  node [
    id 11
    label "11"
    cpu 21
    gpu 19
    rom 38
  ]
  node [
    id 12
    label "12"
    cpu 20
    gpu 20
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 36
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
  edge [
    source 11
    target 12
    bw 35
  ]
]
