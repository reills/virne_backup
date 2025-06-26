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
  id 875
  arrival_time 18178.76455909097
  lifetime 4656.729679528581
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 23
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 42
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 0
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 40
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 18
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 45
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 21
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 7
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 17
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 48
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
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
]
