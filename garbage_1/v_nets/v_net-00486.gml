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
  id 486
  arrival_time 8960.27207981456
  lifetime 782.3771939575372
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 39
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 5
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 16
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 28
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 13
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 4
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 50
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 10
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 50
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 17
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
]
