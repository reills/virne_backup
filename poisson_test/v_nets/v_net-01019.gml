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
  id 1019
  arrival_time 21665.470177949246
  lifetime 318.77369553303646
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 7
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 4
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 0
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 18
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 41
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 44
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 38
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 8
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 27
    rom 16
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 44
    rom 35
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 0
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
]
