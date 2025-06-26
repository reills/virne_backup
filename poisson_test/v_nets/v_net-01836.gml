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
  id 1836
  arrival_time 40530.767514879066
  lifetime 139.59799274788463
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 41
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 32
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 28
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 31
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 21
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 18
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 31
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 8
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
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
]
