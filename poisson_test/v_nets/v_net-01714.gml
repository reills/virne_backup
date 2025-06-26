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
  id 1714
  arrival_time 38209.79523022693
  lifetime 349.12604500494285
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 40
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 15
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 3
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 19
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 13
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 23
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 20
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 44
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
]
