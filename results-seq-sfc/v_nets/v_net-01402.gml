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
  id 1402
  arrival_time 29427.08405683971
  lifetime 1486.9560134839514
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 10
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 39
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 13
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 1
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 39
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 26
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 2
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 1
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 6
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 15
    rom 29
  ]
  node [
    id 10
    label "10"
    cpu 50
    gpu 23
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 15
    gpu 29
    rom 14
  ]
  node [
    id 12
    label "12"
    cpu 47
    gpu 35
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 18
  ]
  edge [
    source 10
    target 11
    bw 14
  ]
  edge [
    source 11
    target 12
    bw 38
  ]
]
