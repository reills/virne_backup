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
  id 548
  arrival_time 10355.122389559168
  lifetime 672.7595913772208
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 25
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 35
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 8
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 13
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 10
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 31
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 5
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 49
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 47
    rom 32
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 28
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 19
  ]
]
