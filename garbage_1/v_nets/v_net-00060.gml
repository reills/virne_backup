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
  id 60
  arrival_time 1225.6555949212582
  lifetime 171.14873522125836
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 4
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 43
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 48
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 18
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 34
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 39
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 32
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 3
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 34
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 21
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 48
  ]
]
