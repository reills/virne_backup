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
  id 714
  arrival_time 14883.365607738999
  lifetime 2091.5511602896304
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 20
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 16
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 12
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 23
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 16
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 22
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 15
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 11
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 36
    gpu 23
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 47
    rom 34
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 40
    rom 48
  ]
  node [
    id 11
    label "11"
    cpu 33
    gpu 45
    rom 17
  ]
  node [
    id 12
    label "12"
    cpu 26
    gpu 11
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 37
  ]
  edge [
    source 10
    target 11
    bw 10
  ]
  edge [
    source 11
    target 12
    bw 1
  ]
]
