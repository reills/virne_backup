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
  id 88
  arrival_time 1694.3089811077284
  lifetime 471.15703356816545
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 44
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 12
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 20
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 9
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 47
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 9
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 38
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 36
    rom 26
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 41
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 37
    rom 39
  ]
  node [
    id 10
    label "10"
    cpu 17
    gpu 29
    rom 0
  ]
  node [
    id 11
    label "11"
    cpu 2
    gpu 17
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 20
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
    bw 21
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 40
  ]
]
