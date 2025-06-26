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
  id 1700
  arrival_time 37697.30033335687
  lifetime 2267.098552719548
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 44
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 38
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 48
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 15
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 27
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 29
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 14
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 16
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
]
