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
  id 802
  arrival_time 16673.406846156788
  lifetime 107.19308654257269
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 3
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 41
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 20
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 9
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 34
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 29
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 11
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 29
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 3
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 13
    gpu 9
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 40
    rom 13
  ]
  node [
    id 11
    label "11"
    cpu 18
    gpu 14
    rom 44
  ]
  node [
    id 12
    label "12"
    cpu 28
    gpu 13
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 40
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
  edge [
    source 10
    target 11
    bw 16
  ]
  edge [
    source 11
    target 12
    bw 2
  ]
]
