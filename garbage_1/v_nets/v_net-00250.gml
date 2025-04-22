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
  id 250
  arrival_time 4756.912411006869
  lifetime 957.8466344458611
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 37
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 47
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 29
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 46
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 1
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 33
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 38
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 46
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 23
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 13
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
]
