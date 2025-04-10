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
  id 697
  arrival_time 14704.56745469002
  lifetime 2170.6399113151588
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 49
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 40
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 35
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 3
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 1
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 9
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 6
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 20
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
]
