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
  id 1060
  arrival_time 22342.080566277193
  lifetime 223.01333425943267
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 0
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 36
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 9
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 44
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 27
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 50
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 33
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 48
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
]
