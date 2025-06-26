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
  id 1559
  arrival_time 34921.48158432651
  lifetime 516.6807973918932
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 48
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 32
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 16
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 32
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 25
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 23
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 44
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 36
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 7
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 37
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 16
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
]
