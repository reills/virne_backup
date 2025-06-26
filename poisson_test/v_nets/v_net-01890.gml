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
  id 1890
  arrival_time 41679.30987346041
  lifetime 260.208959187744
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 16
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 10
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 10
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 18
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 49
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 34
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 16
    gpu 25
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 26
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 48
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
]
