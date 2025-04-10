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
  id 323
  arrival_time 6134.802431169327
  lifetime 596.0231731252937
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 32
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 4
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 40
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 19
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 49
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 46
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 29
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 5
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 46
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 36
    gpu 3
    rom 49
  ]
  node [
    id 10
    label "10"
    cpu 37
    gpu 23
    rom 34
  ]
  node [
    id 11
    label "11"
    cpu 46
    gpu 38
    rom 48
  ]
  node [
    id 12
    label "12"
    cpu 29
    gpu 3
    rom 0
  ]
  node [
    id 13
    label "13"
    cpu 17
    gpu 43
    rom 11
  ]
  node [
    id 14
    label "14"
    cpu 30
    gpu 30
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 16
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
  edge [
    source 11
    target 12
    bw 38
  ]
  edge [
    source 12
    target 13
    bw 21
  ]
  edge [
    source 13
    target 14
    bw 44
  ]
]
