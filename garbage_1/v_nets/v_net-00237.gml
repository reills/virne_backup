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
  id 237
  arrival_time 4350.63007292851
  lifetime 248.91642753777168
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 14
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 16
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 16
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 23
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 6
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 50
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 14
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 44
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 11
    gpu 43
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 1
    rom 47
  ]
  node [
    id 10
    label "10"
    cpu 45
    gpu 39
    rom 17
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 23
    rom 38
  ]
  node [
    id 12
    label "12"
    cpu 38
    gpu 26
    rom 34
  ]
  node [
    id 13
    label "13"
    cpu 39
    gpu 30
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
  edge [
    source 11
    target 12
    bw 31
  ]
  edge [
    source 12
    target 13
    bw 18
  ]
]
