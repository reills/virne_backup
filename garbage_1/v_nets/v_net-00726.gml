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
  id 726
  arrival_time 15290.052652178956
  lifetime 94.99369356299148
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 42
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 36
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 19
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 41
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 27
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 6
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 35
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 13
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
]
