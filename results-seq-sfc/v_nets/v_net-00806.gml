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
  id 806
  arrival_time 16709.231755647095
  lifetime 183.79832229654036
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 13
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 25
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 39
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 11
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 28
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 36
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 6
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 49
    gpu 5
    rom 21
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 50
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 44
    gpu 16
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
]
