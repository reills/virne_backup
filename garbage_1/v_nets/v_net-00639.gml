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
  id 639
  arrival_time 13353.341333775381
  lifetime 832.3795691121496
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 39
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 5
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 0
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 45
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 18
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 27
    rom 24
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 12
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 43
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 14
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 16
    rom 0
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 6
    rom 18
  ]
  node [
    id 11
    label "11"
    cpu 1
    gpu 39
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 3
  ]
]
