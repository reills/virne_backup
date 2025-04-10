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
  id 1833
  arrival_time 40490.863037168776
  lifetime 1047.350463058523
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 10
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 24
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 45
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 46
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 21
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 3
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 22
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 38
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 30
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 48
    rom 28
  ]
  node [
    id 10
    label "10"
    cpu 34
    gpu 50
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 29
    rom 11
  ]
  node [
    id 12
    label "12"
    cpu 47
    gpu 4
    rom 8
  ]
  node [
    id 13
    label "13"
    cpu 45
    gpu 18
    rom 46
  ]
  node [
    id 14
    label "14"
    cpu 24
    gpu 39
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 23
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
  edge [
    source 11
    target 12
    bw 4
  ]
  edge [
    source 12
    target 13
    bw 9
  ]
  edge [
    source 13
    target 14
    bw 22
  ]
]
