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
  id 924
  arrival_time 19809.881981205483
  lifetime 108.51169253642126
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 24
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 43
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 33
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 40
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 44
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 2
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 49
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 41
    gpu 5
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 33
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 45
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 45
    rom 20
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 22
    rom 32
  ]
  node [
    id 12
    label "12"
    cpu 45
    gpu 43
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 38
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
  edge [
    source 10
    target 11
    bw 48
  ]
  edge [
    source 11
    target 12
    bw 26
  ]
]
