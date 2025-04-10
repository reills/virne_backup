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
  id 1336
  arrival_time 28238.84893542112
  lifetime 194.39418668183205
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 13
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 49
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 25
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 49
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 20
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 22
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 40
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 43
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 15
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 31
    rom 45
  ]
  node [
    id 10
    label "10"
    cpu 36
    gpu 35
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 14
  ]
]
