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
  id 778
  arrival_time 16173.0523680692
  lifetime 309.19898694421227
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 46
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 35
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 47
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 35
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 13
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 45
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 49
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 49
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 39
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 44
    gpu 19
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
]
