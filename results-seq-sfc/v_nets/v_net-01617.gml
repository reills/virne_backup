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
  id 1617
  arrival_time 36136.53445638366
  lifetime 866.1623573214105
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 13
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 7
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 23
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 45
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 43
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 24
    rom 23
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 28
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 38
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 16
    rom 16
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 48
    rom 10
  ]
  node [
    id 10
    label "10"
    cpu 20
    gpu 2
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
]
