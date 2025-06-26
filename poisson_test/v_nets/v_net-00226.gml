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
  id 226
  arrival_time 4121.611990798707
  lifetime 2084.999295214925
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 32
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 19
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 11
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 9
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 12
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 23
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 16
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 46
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
]
