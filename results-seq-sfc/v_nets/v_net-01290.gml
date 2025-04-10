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
  id 1290
  arrival_time 27046.682173160498
  lifetime 642.2108183287278
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 2
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 10
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 24
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 3
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 43
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 5
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 3
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 33
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 4
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 13
    gpu 10
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 9
    gpu 25
    rom 42
  ]
  node [
    id 11
    label "11"
    cpu 39
    gpu 27
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 13
  ]
  edge [
    source 10
    target 11
    bw 49
  ]
]
