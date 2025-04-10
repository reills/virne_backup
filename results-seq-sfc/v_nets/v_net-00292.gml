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
  id 292
  arrival_time 5668.637270365157
  lifetime 456.97651915900803
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 44
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 21
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 13
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 45
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 20
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 24
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 46
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 32
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 25
    rom 37
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 6
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 41
    gpu 48
    rom 5
  ]
  node [
    id 11
    label "11"
    cpu 11
    gpu 15
    rom 49
  ]
  node [
    id 12
    label "12"
    cpu 19
    gpu 42
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 46
  ]
  edge [
    source 11
    target 12
    bw 22
  ]
]
