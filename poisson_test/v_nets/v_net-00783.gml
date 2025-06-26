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
  id 783
  arrival_time 16185.70334837812
  lifetime 1255.6809528370911
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 46
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 23
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 27
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 43
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 2
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 50
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 14
    rom 48
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 26
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 19
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 28
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
]
