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
  id 1364
  arrival_time 28837.83490913956
  lifetime 74.3106901400675
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 39
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 47
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 37
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 34
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 42
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 9
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 2
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 30
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 1
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
]
