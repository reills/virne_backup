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
  id 1998
  arrival_time 43661.40817573948
  lifetime 313.495872370192
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 9
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 45
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 33
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 43
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 12
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 37
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 24
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
]
