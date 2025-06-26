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
  id 1554
  arrival_time 34229.39723771868
  lifetime 141.22301073032975
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 18
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 2
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 27
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 0
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 35
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 37
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 27
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 41
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
]
