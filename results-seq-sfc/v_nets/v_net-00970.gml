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
  id 970
  arrival_time 20543.36627050336
  lifetime 1135.5118470295613
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 25
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 14
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 19
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 39
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 14
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 20
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 42
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 8
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 44
    gpu 35
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 18
    gpu 44
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 32
    gpu 46
    rom 29
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 0
    rom 14
  ]
  node [
    id 12
    label "12"
    cpu 35
    gpu 36
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 42
  ]
  edge [
    source 10
    target 11
    bw 24
  ]
  edge [
    source 11
    target 12
    bw 21
  ]
]
