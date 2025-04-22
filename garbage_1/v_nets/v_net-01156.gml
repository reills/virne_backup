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
  id 1156
  arrival_time 24054.09150760417
  lifetime 1761.8944661567593
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 47
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 41
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 37
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 15
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 49
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 48
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 10
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 31
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 37
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 1
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 13
    rom 11
  ]
  node [
    id 11
    label "11"
    cpu 22
    gpu 25
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
  edge [
    source 9
    target 10
    bw 34
  ]
  edge [
    source 10
    target 11
    bw 10
  ]
]
