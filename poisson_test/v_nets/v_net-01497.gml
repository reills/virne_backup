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
  id 1497
  arrival_time 33313.78210888844
  lifetime 1858.0553539070722
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 21
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 4
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 24
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 41
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 33
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 48
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 23
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 47
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 36
    gpu 17
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 23
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
]
