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
  id 1759
  arrival_time 39190.1424360607
  lifetime 719.6000891999196
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 6
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 36
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 30
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 20
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 31
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 2
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 45
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 30
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 43
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 23
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
]
