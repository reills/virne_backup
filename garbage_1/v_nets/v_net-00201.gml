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
  id 201
  arrival_time 3575.597145674584
  lifetime 929.4913373536341
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 23
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 27
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 8
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 12
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 27
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 20
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 19
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 15
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 31
    gpu 32
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 36
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 0
    gpu 27
    rom 38
  ]
  node [
    id 11
    label "11"
    cpu 50
    gpu 0
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
  edge [
    source 10
    target 11
    bw 46
  ]
]
