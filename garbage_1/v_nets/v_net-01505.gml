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
  id 1505
  arrival_time 33430.18770935578
  lifetime 1166.2320512672911
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 37
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 48
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 17
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 26
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 31
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 22
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 47
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 33
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 32
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 17
    gpu 4
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 34
    gpu 14
    rom 40
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 43
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 35
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
]
