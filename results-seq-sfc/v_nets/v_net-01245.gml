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
  id 1245
  arrival_time 25695.78325384355
  lifetime 805.5674238415812
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 4
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 33
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 44
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 18
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 28
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 48
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 17
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 38
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 4
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 19
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 4
    gpu 45
    rom 31
  ]
  node [
    id 11
    label "11"
    cpu 16
    gpu 38
    rom 48
  ]
  node [
    id 12
    label "12"
    cpu 16
    gpu 34
    rom 38
  ]
  node [
    id 13
    label "13"
    cpu 46
    gpu 50
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 26
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
  edge [
    source 10
    target 11
    bw 8
  ]
  edge [
    source 11
    target 12
    bw 24
  ]
  edge [
    source 12
    target 13
    bw 48
  ]
]
