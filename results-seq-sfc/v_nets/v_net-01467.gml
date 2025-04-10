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
  id 1467
  arrival_time 31930.276581302478
  lifetime 977.8119738941892
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 5
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 41
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 33
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 49
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 31
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 14
    rom 20
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 1
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 49
    gpu 8
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 4
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
  edge [
    source 6
    target 7
    bw 22
  ]
  edge [
    source 7
    target 8
    bw 7
  ]
]
