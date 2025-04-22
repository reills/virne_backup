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
  id 1197
  arrival_time 24727.927490831204
  lifetime 211.55213098690737
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 9
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 18
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 38
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 43
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 24
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 27
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 49
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 36
    rom 21
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 39
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 27
    rom 43
  ]
  node [
    id 10
    label "10"
    cpu 4
    gpu 20
    rom 43
  ]
  node [
    id 11
    label "11"
    cpu 13
    gpu 26
    rom 50
  ]
  node [
    id 12
    label "12"
    cpu 0
    gpu 28
    rom 9
  ]
  node [
    id 13
    label "13"
    cpu 0
    gpu 26
    rom 42
  ]
  node [
    id 14
    label "14"
    cpu 46
    gpu 44
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 7
  ]
  edge [
    source 8
    target 9
    bw 25
  ]
  edge [
    source 9
    target 10
    bw 2
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
  edge [
    source 11
    target 12
    bw 34
  ]
  edge [
    source 12
    target 13
    bw 43
  ]
  edge [
    source 13
    target 14
    bw 15
  ]
]
