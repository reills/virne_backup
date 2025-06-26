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
  id 2
  arrival_time 53.54671385330967
  lifetime 33.67098344883009
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 35
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 1
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 13
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 46
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 18
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 16
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 23
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 36
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 38
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
]
