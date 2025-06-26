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
  id 1852
  arrival_time 40861.51647874218
  lifetime 583.9812013286318
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 14
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 19
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 50
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 16
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 19
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 43
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 15
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 13
    rom 2
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 12
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 15
  ]
]
