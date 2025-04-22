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
  id 1805
  arrival_time 40072.45975517835
  lifetime 992.1350849474695
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 30
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 30
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 0
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 2
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 20
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 43
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 31
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 33
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 41
    gpu 1
    rom 30
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 34
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
]
