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
  id 394
  arrival_time 7819.120646017259
  lifetime 738.255460132457
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 20
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 7
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 50
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 3
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 16
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 12
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 16
    gpu 48
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 20
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 42
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 23
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
]
