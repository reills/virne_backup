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
  id 90
  arrival_time 1707.4879699331923
  lifetime 1377.3817998786835
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 38
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 36
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 26
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 22
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 48
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 20
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 16
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 1
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
]
