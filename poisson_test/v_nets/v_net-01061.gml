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
  id 1061
  arrival_time 22346.57094352245
  lifetime 984.6234127822262
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 13
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 9
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 43
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 22
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 44
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 40
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 46
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 9
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 35
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 8
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 49
    gpu 45
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 25
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
  edge [
    source 9
    target 10
    bw 24
  ]
]
