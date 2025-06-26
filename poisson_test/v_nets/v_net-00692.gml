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
  id 692
  arrival_time 14590.357168136823
  lifetime 117.45187314493425
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 17
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 13
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 14
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 6
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 38
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 19
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 23
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 7
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 22
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 0
    gpu 26
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
]
