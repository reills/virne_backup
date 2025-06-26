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
  id 1370
  arrival_time 29157.833129340255
  lifetime 999.2206328391279
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 39
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 42
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 48
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 43
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 30
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 2
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 3
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 22
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
]
