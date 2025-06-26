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
  id 742
  arrival_time 15542.832561478937
  lifetime 1364.8052066378277
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 36
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 25
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 46
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 46
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 33
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 45
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 18
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 4
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 42
    rom 7
  ]
  node [
    id 9
    label "9"
    cpu 42
    gpu 24
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 15
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 32
  ]
  edge [
    source 9
    target 10
    bw 3
  ]
]
