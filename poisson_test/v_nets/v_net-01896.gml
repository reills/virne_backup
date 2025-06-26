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
  id 1896
  arrival_time 41910.40892441092
  lifetime 637.6837367144242
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 14
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 26
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 50
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 25
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 16
    rom 47
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 5
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 14
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 30
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 34
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 17
    rom 37
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 9
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 45
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
]
