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
  id 1178
  arrival_time 24383.669701668066
  lifetime 350.5601695533429
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 35
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 34
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 44
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 24
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 49
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 37
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 26
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 17
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 17
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 47
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 24
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 44
    gpu 43
    rom 27
  ]
  node [
    id 12
    label "12"
    cpu 0
    gpu 50
    rom 1
  ]
  node [
    id 13
    label "13"
    cpu 5
    gpu 45
    rom 17
  ]
  node [
    id 14
    label "14"
    cpu 44
    gpu 34
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
  edge [
    source 9
    target 10
    bw 46
  ]
  edge [
    source 10
    target 11
    bw 37
  ]
  edge [
    source 11
    target 12
    bw 18
  ]
  edge [
    source 12
    target 13
    bw 0
  ]
  edge [
    source 13
    target 14
    bw 31
  ]
]
