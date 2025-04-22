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
  id 1541
  arrival_time 34025.610543989205
  lifetime 223.14860091988746
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 41
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 36
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 13
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 50
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 31
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 8
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 42
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 40
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
]
