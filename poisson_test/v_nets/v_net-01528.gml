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
  id 1528
  arrival_time 33824.066250395044
  lifetime 2028.2637375691284
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 48
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 11
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 23
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 24
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 16
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 9
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 10
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 9
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 2
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 19
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
]
