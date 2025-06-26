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
  id 713
  arrival_time 14877.857302804536
  lifetime 4670.603688448273
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 35
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 35
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 4
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 44
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 2
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 45
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 36
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 20
    rom 3
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 28
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 28
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 24
    rom 47
  ]
  node [
    id 11
    label "11"
    cpu 7
    gpu 16
    rom 6
  ]
  node [
    id 12
    label "12"
    cpu 11
    gpu 44
    rom 38
  ]
  node [
    id 13
    label "13"
    cpu 33
    gpu 4
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 28
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
  edge [
    source 9
    target 10
    bw 31
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
  edge [
    source 11
    target 12
    bw 29
  ]
  edge [
    source 12
    target 13
    bw 19
  ]
]
