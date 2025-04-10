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
  id 1003
  arrival_time 21511.50876312619
  lifetime 806.9894003412477
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 3
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 37
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 10
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 29
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 28
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 28
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 39
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 44
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 17
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 8
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 21
    gpu 1
    rom 32
  ]
  node [
    id 11
    label "11"
    cpu 6
    gpu 9
    rom 27
  ]
  node [
    id 12
    label "12"
    cpu 9
    gpu 43
    rom 43
  ]
  node [
    id 13
    label "13"
    cpu 12
    gpu 13
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
  edge [
    source 9
    target 10
    bw 5
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
  edge [
    source 11
    target 12
    bw 23
  ]
  edge [
    source 12
    target 13
    bw 0
  ]
]
