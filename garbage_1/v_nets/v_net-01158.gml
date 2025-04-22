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
  id 1158
  arrival_time 24073.301760805265
  lifetime 962.3305792493194
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 5
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 13
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 9
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 37
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 38
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 11
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 11
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 36
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 0
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 44
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 18
    gpu 36
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
]
