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
  id 1936
  arrival_time 42666.8821295072
  lifetime 1176.6981845040953
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 15
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 9
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 10
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 6
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 0
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 19
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 35
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 24
    gpu 44
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 3
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 44
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
]
